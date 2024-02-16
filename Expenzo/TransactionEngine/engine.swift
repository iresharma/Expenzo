//
//  engine.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import Foundation

func getTransactionAmount(message: [String]) -> String {
    guard let index = message.firstIndex(of: "rs.") else {
        return ""
    }
    
    var money = message[index + 1]
    money = money.replacingOccurrences(of: ",", with: "")
    
    if let moneyNumber = Double(money) {
        return padCurrencyValue("\(moneyNumber)")
    } else {
        money = message[index + 2].replacingOccurrences(of: ",", with: "")
        if let moneyNumber = Double(money) {
            return padCurrencyValue("\(moneyNumber)")
        } else {
            return ""
        }
    }
}

func getTransactionType(message: [String]) -> String? {
    let creditPattern = "(?:credited|credit|deposited|added|received|refund|repayment)"
    let debitPattern = "(?:debited|debit|deducted)"
    let miscPattern = "(?:payment|spent|paid|used\\s+at|charged|transaction\\son|transaction\\sfee|tran|booked|purchased|sent\\s+to|purchase\\s+of)"
    
    let messageStr = message.joined(separator: " ")
    
    if messageStr.range(of: debitPattern, options: .regularExpression) != nil {
        return "debit"
    }
    if messageStr.range(of: creditPattern, options: .regularExpression) != nil {
        return "credit"
    }
    if messageStr.range(of: miscPattern, options: .regularExpression) != nil {
        return "debit"
    }
    
    return nil
}

func getTransactionInfo(message: String) -> ITransactionInfo {
    
    let processedMessage = processMessage(message)
    let account = getAccount(processedMessage: processedMessage)
    let availableBalance = getBalance(processedMessage: processedMessage, keyWordType: .AVAILABLE)
    let transactionAmount = getTransactionAmount(message: processedMessage)
    let isValid = [availableBalance, transactionAmount, account.number].filter { $0 != nil }.count >= 2
    let transactionType = isValid ? getTransactionType(message: processedMessage) : nil
    
    var balance: [String: String?] = ["available": availableBalance, "outstanding": nil]
    
    if account.type?.rawValue == IAccountType.CARD.rawValue {
        balance["outstanding"] = getBalance(processedMessage: processedMessage, keyWordType: .OUTSTANDING)
    }
    
    let balanceStruct = IBalance(available: balance["available"]! ?? "", outstanding: balance["outstanding"]! ?? "")
    
    let merchantInfo = extractMerchantInfo(processedMessage)
    
    let transaction = ITransaction(type: transactionType, amount: transactionAmount, referenceNo: merchantInfo.referenceNo, merchant: merchantInfo.merchant)
    
    return ITransactionInfo(account: account, balance: balanceStruct, transaction: transaction)

}
