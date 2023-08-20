import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"
import "FlovatarDustCollectible"
import "FlovatarDustCollectibleTemplate"
import "FlovatarDustToken"
import "FlovatarComponentUpgrader"


transaction(
    componentIds: [UInt64]
    ) {

    let componentCollection: &FlovatarComponent.Collection
    let upgraderCollection: &FlovatarComponentUpgrader.Collection

    prepare(account: AuthAccount) {

        self.componentCollection = account.borrow<&FlovatarComponent.Collection>(from: FlovatarComponent.CollectionStoragePath)!
        self.upgraderCollection = account.borrow<&FlovatarComponentUpgrader.Collection>(from: FlovatarComponentUpgrader.CollectionStoragePath)!
    }

    execute {

        for componentId in componentIds {
            let tempNFT <-self.componentCollection.withdraw(withdrawID: componentId) as! @FlovatarComponent.NFT
            self.upgraderCollection.depositComponent(component: <- tempNFT)
        }
    }
}