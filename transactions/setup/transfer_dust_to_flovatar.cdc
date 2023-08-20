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

//This transactions transfers flow on testnet from one account to another
transaction(
    amount: UFix64,
    to: UInt64) {

      let sentVault: @FungibleToken.Vault

      prepare(signer: AuthAccount) {
        let vaultRef = signer.borrow<&{FungibleToken.Provider}>(from: FlovatarDustToken.VaultStoragePath)
          ?? panic("Could not borrow reference to the owner's Vault!")

        self.sentVault <- vaultRef.withdraw(amount: amount)
      }

      execute {
        if let inboxCollection = signer.getCapability(FlovatarInbox.CollectionPublicPath).borrow<&{FlovatarInbox.CollectionPublic}>() {
            inboxCollection.depositDustToFlovatar(id: to, vault: <-self.sentVault)
        }
      }
}
