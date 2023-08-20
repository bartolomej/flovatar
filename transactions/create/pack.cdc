import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


//this transaction will create a new Pack from a group of components
transaction(
    components: [UInt64],
    randomString: String,
    price: UFix64,
    sparkCount: UInt32,
    series: UInt32,
    name: String
    ) {

    let flovatarComponentCollection: &FlovatarComponent.Collection
    let flovatarPackCollection: &FlovatarPack.Collection
    let flovatarAdmin: &Flovatar.Admin

    let componentsNFT: @[FlovatarComponent.NFT]


    prepare(account: AuthAccount) {

        self.componentsNFT <- []

        self.flovatarComponentCollection = account.borrow<&FlovatarComponent.Collection>(from: FlovatarComponent.CollectionStoragePath)!

        self.flovatarPackCollection = account.borrow<&FlovatarPack.Collection>(from: FlovatarPack.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&Flovatar.Admin>(from: Flovatar.AdminStoragePath)!

        for componentId in components {
            let tempNFT <- self.flovatarComponentCollection.withdraw(withdrawID: componentId) as! @FlovatarComponent.NFT
            self.componentsNFT.append(<-tempNFT)
        }

    }

    execute {
        let flovatarPack <- self.flovatarAdmin.createPack(
            components: <-self.componentsNFT,
            randomString: randomString,
            price: price,
            sparkCount: sparkCount,
            series: series,
            name: name
        ) as! @FlovatarPack.Pack

        self.flovatarPackCollection.deposit(token: <-flovatarPack)

    }
}
