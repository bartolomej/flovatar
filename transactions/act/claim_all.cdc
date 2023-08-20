import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"
import "FlovatarDustToken"
import "FlovatarInbox"


//this transaction will claim all content of the Inbox
transaction() {

    let flovatarCollection: &Flovatar.Collection
    let address: Address

    prepare(account: AuthAccount) {
        self.flovatarCollection = account.borrow<&Flovatar.Collection>(from: Flovatar.CollectionStoragePath)!
        self.address = account.address


        let dustTokenCap = account.getCapability<&FlovatarDustToken.Vault{FungibleToken.Receiver}>(FlovatarDustToken.VaultReceiverPath)
        if(!dustTokenCap.check()) {
            let vault <- FlovatarDustToken.createEmptyVault()
            // Store the vault in the account storage
            account.save<@FlovatarDustToken.Vault>(<-vault, to: FlovatarDustToken.VaultStoragePath)
            // Create a public Receiver capability to the Vault
            let ReceiverRef = account.link<&FlovatarDustToken.Vault{FungibleToken.Receiver, FungibleToken.Balance}>(FlovatarDustToken.VaultReceiverPath, target: FlovatarDustToken.VaultStoragePath)
        }
    }

    execute {


        FlovatarInbox.withdrawWalletComponent(address: self.address)
        FlovatarInbox.withdrawWalletDust(address: self.address)

        for id in self.flovatarCollection.getIDs() {
            FlovatarInbox.withdrawFlovatarComponent(id: id, address: self.address)
            FlovatarInbox.withdrawFlovatarDust(id: id, address: self.address)
            FlovatarInbox.claimFlovatarCommunityDust(id: id, address: self.address)
        }
    }
}