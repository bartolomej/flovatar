import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


transaction() {
    prepare(account: AuthAccount) {
        if(account.getCapability<&{FlovatarPack.CollectionPublic}>(FlovatarPack.CollectionPublicPath) == nil) {
            let wallet =  account.getCapability<&FlowToken.Vault{FungibleToken.Receiver}>(/public/flowTokenReceiver)
            account.save<@FlovatarPack.Collection>(<- FlovatarPack.createEmptyCollection(ownerVault: wallet), to: FlovatarPack.CollectionStoragePath)
            account.link<&{FlovatarPack.CollectionPublic}>(FlovatarPack.CollectionPublicPath, target: FlovatarPack.CollectionStoragePath)
        }
    }

}