import Foundation

let availableBalanceKeywords = [
    "avbl bal",
    "available balance",
    "available limit",
    "available credit limit",
    "limit available",
    "a/c bal",
    "ac bal",
    "available bal",
    "avl bal",
    "updated balance",
    "total balance",
    "new balance",
    "bal",
    "avl lmt",
    "available"
]

let outstandingBalanceKeywords = ["outstanding"]

let wallets = ["paytm", "simpl", "lazypay", "amazon_pay"]

let upiKeywords = ["upi", "ref no", "upi ref", "upi ref no"]

let combinedWords: [ICombinedWords] = [
    try! ICombinedWords(regex: NSRegularExpression(pattern: "credit\\s*card", options: []), word: "c_card", type: .CARD),
    try! ICombinedWords(regex: NSRegularExpression(pattern: "amazon\\s*pay", options: []), word: "amazon_pay", type: .WALLET),
    try! ICombinedWords(regex: NSRegularExpression(pattern: "uni\\s*card", options: []), word: "uni_card", type: .CARD),
    try! ICombinedWords(regex: NSRegularExpression(pattern: "niyo\\s*card", options: []), word: "niyo", type: .ACCOUNT),
    try! ICombinedWords(regex: NSRegularExpression(pattern: "slice\\s*card", options: []), word: "slice_card", type: .CARD),
    try! ICombinedWords(regex: NSRegularExpression(pattern: "one\\s*card", options: []), word: "one_card", type: .CARD)
]
