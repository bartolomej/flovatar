import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


// This script returns a specific Flovatar sale

pub fun main(address:Address, id: UInt64) : FlovatarMarketplace.FlovatarSaleData? {

    return FlovatarMarketplace.getFlovatarSale(address: address, id: id)

}
