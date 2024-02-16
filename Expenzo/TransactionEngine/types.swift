import Foundation
enum IAccountType: String {
    case CARD = "CARD"
    case WALLET = "WALLET"
    case ACCOUNT = "ACCOUNT"
}

enum IBalanceKeyWordsType: String {
    case AVAILABLE = "AVAILABLE"
    case OUTSTANDING = "OUTSTANDING"
}

struct IAccountInfo {
    var type: IAccountType?
    var number: String?
    var name: String?
}

struct IBalance {
    var available: String?
    var outstanding: String?
}

typealias TMessageType = [String]
typealias TTransactionType = String?

struct ITransaction {
    var type: TTransactionType
    var amount: String?
    var referenceNo: String?
    var merchant: String?
}

struct ITransactionInfo {
    var account: IAccountInfo
    var balance: IBalance?
    var transaction: ITransaction
}

struct ICombinedWords {
    var regex: NSRegularExpression
    var word: String
    var type: IAccountType
}


extension ITransactionInfo {
    func toString() -> String {
        var infoString = ""
        
        // Account Info
        if let type = account.type {
            infoString += "Account Type: \(type.rawValue)\n"
        }
        if let number = account.number {
            infoString += "Account Number: \(number)\n"
        }
        if let name = account.name {
            infoString += "Account Name: \(name)\n"
        }
        
        // Balance Info
        if let balance = balance {
            if let available = balance.available {
                infoString += "Available Balance: \(available)\n"
            }
            if let outstanding = balance.outstanding {
                infoString += "Outstanding Balance: \(outstanding)\n"
            }
        }
        
        // Transaction Info
        if let type = transaction.type {
            infoString += "Transaction Type: \(type)\n"
        }
        if let amount = transaction.amount {
            infoString += "Transaction Amount: \(amount)\n"
        }
        if let referenceNo = transaction.referenceNo {
            infoString += "Transaction Reference No: \(referenceNo)\n"
        }
        if let merchant = transaction.merchant {
            infoString += "Transaction Merchant: \(merchant)\n"
        }
        
        return infoString
    }
}
