import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


transaction(templateId: UInt64) {

    let flovatarComponentCollection: &FlovatarComponent.Collection
    let flovatarAdmin: &Flovatar.Admin

    prepare(account: AuthAccount) {
        self.flovatarComponentCollection = account.borrow<&FlovatarComponent.Collection>(from: FlovatarComponent.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&Flovatar.Admin>(from: Flovatar.AdminStoragePath)!
    }

    execute {
        let flovatarComponent <- self.flovatarAdmin.createComponent(templateId: templateId) as! @FlovatarComponent.NFT

        self.flovatarComponentCollection.deposit(token: <-flovatarComponent)

    }
}