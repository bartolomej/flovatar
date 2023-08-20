import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns the available webshots

pub fun main(address:Address, flovatarId: UInt64) : Flovatar.FlovatarData? {

    return Flovatar.getFlovatar(address: address, flovatarId: flovatarId)

}
