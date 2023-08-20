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
import "FlovatarDustCollectibleAccessory"


transaction(templateId: UInt64) {

    let flovatarDustAccessoryCollection: &FlovatarDustCollectibleAccessory.Collection
    let flovatarAdmin: &FlovatarDustCollectible.Admin

    prepare(account: AuthAccount) {
        self.flovatarDustAccessoryCollection = account.borrow<&FlovatarDustCollectibleAccessory.Collection>(from: FlovatarDustCollectibleAccessory.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&FlovatarDustCollectible.Admin>(from: FlovatarDustCollectible.AdminStoragePath)!
    }

    execute {
        let flovatarDustAccessory <- self.flovatarAdmin.createCollectible(templateId: templateId) as! @FlovatarDustCollectibleAccessory.NFT

        self.flovatarDustAccessoryCollection.deposit(token: <-flovatarDustAccessory)

    }
}