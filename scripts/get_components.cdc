import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns the available components

pub fun main(address:Address) : [FlovatarComponent.ComponentData] {

    return FlovatarComponent.getComponents(address: address)

}
