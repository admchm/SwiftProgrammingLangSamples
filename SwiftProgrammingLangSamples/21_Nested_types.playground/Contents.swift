import UIKit

// To nest a type within another type, write its definition withing the
// outer braces of the type it supports. Types can be nested to as many
// levels as are required.

/** NESTED TYPES IN ACTION **/

struct BlackjackCard {
    
    // nested suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, eight, nine, ten
        case jack, queen, king, ace
        
        struct Values {
            let first: Int, second: Int?
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackJackCard properties and methods
    let rank: Rank
    let suit: Suit
    
    var description: String {
        var output = "suit is \(suit.rawValue), "
        output += "value is \(rank.values.first)"
        
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")

/** REFERRING TO NESTED TYPES **/
let heartSymbol = BlackjackCard.Suit.hearts.rawValue
