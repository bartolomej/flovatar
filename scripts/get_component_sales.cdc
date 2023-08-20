import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"



// This script returns the available Flovatar Component sales

pub fun main(address:Address) : [FlovatarMarketplace.FlovatarComponentSaleData] {

    return FlovatarMarketplace.getFlovatarComponentSales(address: address)

}
