import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


// This script returns the available websites

pub fun main(address:Address, id: UInt64) : FlovatarMarketplace.FlovatarComponentSaleData? {

    return FlovatarMarketplace.getFlovatarComponentSale(address: address, id: id)

}
