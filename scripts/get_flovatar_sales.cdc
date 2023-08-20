import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns the available Flovatar sales

pub fun main(address:Address) : [FlovatarMarketplace.FlovatarSaleData] {

    return FlovatarMarketplace.getFlovatarSales(address: address)

}
