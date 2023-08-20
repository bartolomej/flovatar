import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


//this transaction will create a new Webshot and create and auction for it
transaction(
    name: String,
    category: String,
    color: String,
    description: String,
    svg: String,
    series: UInt32,
    maxMintableComponents: UInt64
    rarity: String) {

    let flovatarComponentTemplateCollection: &FlovatarComponentTemplate.Collection
    let flovatarAdmin: &Flovatar.Admin

    prepare(account: AuthAccount) {
        self.flovatarComponentTemplateCollection = account.borrow<&FlovatarComponentTemplate.Collection>(from: FlovatarComponentTemplate.CollectionStoragePath)!

        self.flovatarAdmin = account.borrow<&Flovatar.Admin>(from: Flovatar.AdminStoragePath)!
    }

    execute {
        let flovatarComponentTemplate <- self.flovatarAdmin.createComponentTemplate(
            name: name,
            category: category,
            color: color,
            description: description,
            svg: svg,
            series: series,
            maxMintableComponents: maxMintableComponents,
            rarity: rarity
            ) as! @FlovatarComponentTemplate.ComponentTemplate


        self.flovatarComponentTemplateCollection.deposit(componentTemplate: <-flovatarComponentTemplate)

    }
}
