import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"
import "FlovatarDustToken"

//This transactions transfers flow on testnet from one account to another
transaction(
    amount: UFix64,
    to: Address) {

      let sentVault: @FungibleToken.Vault

      prepare(signer: AuthAccount) {
        let vaultRef = signer.borrow<&{FungibleToken.Provider}>(from: FlovatarDustToken.VaultStoragePath)
          ?? panic("Could not borrow reference to the owner's Vault!")

        self.sentVault <- vaultRef.withdraw(amount: amount)
      }

      execute {
        let recipient = getAccount(to)

        let receiverRef = recipient.getCapability(FlovatarDustToken.VaultReceiverPath)!.borrow<&{FungibleToken.Receiver}>()
          ?? panic("Could not borrow receiver reference to the recipient's Vault")

        receiverRef.deposit(from: <-self.sentVault)
      }
}