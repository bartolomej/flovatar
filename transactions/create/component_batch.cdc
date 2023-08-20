import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


transaction(templateId: UInt64, quantity: UInt64) {

    let flovatarComponentCollection: &FlovatarComponent.Collection
    let flovatarAdmin: &Flovatar.Admin

    prepare(account: AuthAccount) {
        self.flovatarComponentCollection = account.borrow<&FlovatarComponent.Collection>(from: FlovatarComponent.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&Flovatar.Admin>(from: Flovatar.AdminStoragePath)!
    }

    execute {
        let collection <- self.flovatarAdmin.batchCreateComponents(templateId: templateId, quantity: quantity) as! @FlovatarComponent.Collection

        for id in collection.getIDs() {
            self.flovatarComponentCollection.deposit(token: <- collection.withdraw(withdrawID: id))
        }

        destroy collection

    }
}