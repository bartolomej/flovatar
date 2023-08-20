import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"
import "FlovatarInbox"

pub struct Claimables {

  pub(set) var address: Address
  pub(set) var components: [UInt64]
  pub(set) var dust: UFix64
  init (_ address:Address) {
    self.address = address
    self.components = []
    self.dust = 0.0
  }
}

pub fun main(address:Address) : Claimables {
    // get the accounts' public address objects
    let status = Claimables(address)
    let account = getAccount(address)

    status.components = FlovatarInbox.getWalletComponentIDs(address: address)
    status.dust = FlovatarInbox.getWalletDustBalance(address: address)

    return status
}