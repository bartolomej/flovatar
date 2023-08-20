import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns the available components

pub fun main(address:Address, componentId: UInt64) : FlovatarComponent.ComponentData? {

    return FlovatarComponent.getComponent(address: address, componentId: componentId)

}
