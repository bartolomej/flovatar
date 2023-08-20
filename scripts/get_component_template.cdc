import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns a specific Component Template

pub fun main(id: UInt64) : FlovatarComponentTemplate.ComponentTemplateData? {

    return FlovatarComponentTemplate.getComponentTemplate(id: id)

}
