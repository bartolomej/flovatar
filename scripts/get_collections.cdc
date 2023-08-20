import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"

pub struct Collections {

  pub(set) var address: Address
  pub(set) var flovatars: [Flovatar.FlovatarData]
  pub(set) var components: [FlovatarComponent.ComponentData]
  pub(set) var packs: [UInt64]
  init (_ address:Address) {
    self.address = address
    self.flovatars = []
    self.components = []
    self.packs = []
  }
}

pub fun main(address:Address) : Collections {
    // get the accounts' public address objects
    let account = getAccount(address)
    let status = Collections(address)

    status.flovatars = Flovatar.getFlovatars(address: address)
    status.components = FlovatarComponent.getComponents(address: address)
    status.packs = FlovatarPack.getPacks(address: address)!

    return status
}