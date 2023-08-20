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

  pub(set) var id: UInt64
  pub(set) var components: [UInt64]
  pub(set) var dust: UFix64
  pub(set) var communityDust: FlovatarInbox.ClaimableDust?
  init (_ id: UInt64) {
    self.id = id
    self.components = []
    self.dust = 0.0
    self.communityDust = nil
  }
}

pub fun main(id: UInt64, address: Address) : Claimables {
    let status = Claimables(id)
    let account = getAccount(address)

    status.dust = status.flovatarDust + FlovatarInbox.getFlovatarDustBalance(id: id)
    status.communityDust = FlovatarInbox.getClaimableFlovatarCommunityDust(id: id, address: address)
    status.flovatarComponents = FlovatarInbox.getFlovatarComponentIDs(id: id)

    return status
}