import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


//this transaction will add a new pair of Eyeglasses to an existing Flovatar
transaction(
    flovatarId: UInt64,
    eyeglasses: UInt64
    ) {

    let flovatarCollection: &Flovatar.Collection
    let flovatarComponentCollection: &FlovatarComponent.Collection

    let eyeglassesNFT: @FlovatarComponent.NFT

    prepare(account: AuthAccount) {
        self.flovatarCollection = account.borrow<&Flovatar.Collection>(from: Flovatar.CollectionStoragePath)!

        self.flovatarComponentCollection = account.borrow<&FlovatarComponent.Collection>(from: FlovatarComponent.CollectionStoragePath)!

        self.eyeglassesNFT <- self.flovatarComponentCollection.withdraw(withdrawID: eyeglasses) as! @FlovatarComponent.NFT
    }

    execute {

        let flovatar: &{Flovatar.Private} = self.flovatarCollection.borrowFlovatarPrivate(id: flovatarId)!

        let eyeglasses <-flovatar.setEyeglasses(component: <-self.eyeglassesNFT)
        if(eyeglasses != nil){
            self.flovatarComponentCollection.deposit(token: <-eyeglasses!)
        } else {
            destroy eyeglasses
        }
    }
}