import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


//this transaction will send a Pack to an address
transaction(packId: UInt64, address: Address) {
    
    let flovatarPackCollection: &FlovatarPack.Collection
    let flovatarPackReceiverCollection: Capability<&{FlovatarPack.CollectionPublic}>

    prepare(account: AuthAccount) {
        self.flovatarPackCollection = account.borrow<&FlovatarPack.Collection>(from: FlovatarPack.CollectionStoragePath)!


        let receiverAccount = getAccount(address)
        self.flovatarPackReceiverCollection = receiverAccount.getCapability<&{FlovatarPack.CollectionPublic}>(FlovatarPack.CollectionPublicPath)
    }

    execute {
        let pack <- self.flovatarPackCollection.withdraw(withdrawID: packId)
        if(pack == nil){
            panic("Pack not found!")
        }
        self.flovatarPackReceiverCollection.borrow()!.deposit(token: <-pack)
    }
}