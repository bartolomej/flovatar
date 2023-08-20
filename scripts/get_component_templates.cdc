import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns the available websites

pub fun main() : [FlovatarComponentTemplate.ComponentTemplateData] {

    return FlovatarComponentTemplate.getComponentTemplates()

}
