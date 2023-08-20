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


transaction(templateId: UInt64, quantity: UInt64) {


    let flovatarDustAccessoryCollection: &FlovatarDustCollectibleAccessory.Collection
    let flovatarAdmin: &FlovatarDustCollectible.Admin

    prepare(account: AuthAccount) {
        self.flovatarDustAccessoryCollection = account.borrow<&FlovatarDustCollectibleAccessory.Collection>(from: FlovatarDustCollectibleAccessory.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&FlovatarDustCollectible.Admin>(from: FlovatarDustCollectible.AdminStoragePath)!
    }

    execute {
        let collection <- self.flovatarAdmin.batchCreateCollectibles(templateId: templateId, quantity: quantity) as! @FlovatarDustCollectibleAccessory.Collection

        for id in collection.getIDs() {
            self.flovatarDustAccessoryCollection.deposit(token: <- collection.withdraw(withdrawID: id))
        }

        destroy collection

    }
}