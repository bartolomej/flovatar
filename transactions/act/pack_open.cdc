import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


//this transaction will open a Pack from the Collection
transaction(packId: UInt64) {
    
    let flovatarPackCollection: &FlovatarPack.Collection

    prepare(account: AuthAccount) {
        self.flovatarPackCollection = account.borrow<&FlovatarPack.Collection>(from: FlovatarPack.CollectionStoragePath)!
    }

    execute {
        self.flovatarPackCollection.openPack(id: packId)
    }
}