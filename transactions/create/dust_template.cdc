import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"
import "FlovatarDustCollectible"
import "FlovatarDustCollectibleTemplate"


//this transaction will create a new Webshot and create and auction for it
transaction(
    name: String,
    description: String,
    series: UInt64,
    layer: UInt32,
    rarity: String,
    basePrice: UFix64,
    svg: String,
    maxMintableComponents: UInt64) {

    let flovatarDustCollectibleTemplateCollection: &FlovatarDustCollectibleTemplate.Collection
    let flovatarAdmin: &FlovatarDustCollectible.Admin

    prepare(account: AuthAccount) {
        self.flovatarDustCollectibleTemplateCollection = account.borrow<&FlovatarDustCollectibleTemplate.Collection>(from: FlovatarDustCollectibleTemplate.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&FlovatarDustCollectible.Admin>(from: FlovatarDustCollectible.AdminStoragePath)!
    }

    execute {
        let flovatarDustCollectibleTemplate <- self.flovatarAdmin.createComponentTemplate(
            name: name,
            description: description,
            series: series,
            layer: layer,
            metadata: {},
            rarity: rarity,
            basePrice: basePrice,
            svg: svg,
            maxMintableComponents: maxMintableComponents
            ) as! @FlovatarDustCollectibleTemplate.CollectibleTemplate


        self.flovatarDustCollectibleTemplateCollection.deposit(collectibleTemplate: <-flovatarDustCollectibleTemplate)

    }
}