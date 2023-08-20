import "FungibleToken"
import "NonFungibleToken"
import "FlowToken"
import "Flovatar"
import "FlovatarComponent"
import "FlovatarComponentTemplate"
import "FlovatarPack"
import "FlovatarMarketplace"


pub fun main(
    name: String,
    body: UInt64,
    hair: UInt64,
    facialHair: UInt64?,
    eyes: UInt64,
    nose: UInt64,
    mouth: UInt64,
    clothing: UInt64) : {String: Bool} {

    //return Flovatar.checkCombinationAvailable(body: body, hair: hair, facialHair: facialHair, eyes: eyes, nose: nose, mouth: mouth, clothing: clothing) && Flovatar.checkNameAvailable(name: name)

    let boolCombination = Flovatar.checkCombinationAvailable(body: body, hair: hair, facialHair: facialHair, eyes: eyes, nose: nose, mouth: mouth, clothing: clothing)
    let boolName = Flovatar.checkNameAvailable(name: name)
    let status:{String:Bool} = {}
    status["combination"] = boolCombination
    status["name"] = boolName
    status["available"] = boolCombination && boolName
    return status

}