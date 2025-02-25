import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


transaction(
    flovatarId: UInt64,
    price: UFix64
    ) {

    let marketplace: &FlovatarMarketplace.SaleCollection

    prepare(account: AuthAccount) {

        let marketplaceCap = account.getCapability<&{FlovatarMarketplace.SalePublic}>(FlovatarMarketplace.CollectionPublicPath)
        // if sale collection is not created yet we make it.
        if !marketplaceCap.check() {
             let wallet =  account.getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)
             let sale <- FlovatarMarketplace.createSaleCollection(ownerVault: wallet)

            // store an empty NFT Collection in account storage
            account.save<@FlovatarMarketplace.SaleCollection>(<- sale, to:FlovatarMarketplace.CollectionStoragePath)

            // publish a capability to the Collection in storage
            account.link<&{FlovatarMarketplace.SalePublic}>(FlovatarMarketplace.CollectionPublicPath, target: FlovatarMarketplace.CollectionStoragePath)
        }

        self.marketplace=account.borrow<&FlovatarMarketplace.SaleCollection>(from: FlovatarMarketplace.CollectionStoragePath)!
    }

    execute {
        self.marketplace.changeFlovatarPrice(tokenId: flovatarId, newPrice: price)
    }
}