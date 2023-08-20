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


//this transaction will claim all components and Dust for a Flovatar
transaction(id: : UInt64) {

    let address: Address

    prepare(account: AuthAccount) {

        let dustTokenCap = account.getCapability<&FlovatarDustToken.Vault{FlovatarDustToken.Receiver}>(FlovatarDustToken.VaultReceiverPath)
        if(!dustTokenCap.check()) {
            let vault <- FlovatarDustToken.createEmptyVault()
            // Store the vault in the account storage
            account.save<@FlovatarDustToken.Vault>(<-vault, to: FlovatarDustToken.VaultStoragePath)
            // Create a public Receiver capability to the Vault
            let ReceiverRef = account.link<&FlovatarDustToken.Vault{FlovatarDustToken.Receiver, FlovatarDustToken.Balance}>(FlovatarDustToken.VaultReceiverPath, target: FlovatarDustToken.VaultStoragePath)
        }

        self.address = account.address
    }

    execute {

        FlovatarInbox.withdrawFlovatarComponent(id: id, address: self.address)
        FlovatarInbox.withdrawFlovatarDust(id: id, address: self.address)
        FlovatarInbox.claimFlovatarCommunityDust(id: id, address: self.address)

    }
}