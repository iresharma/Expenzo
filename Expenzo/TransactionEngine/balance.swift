//
//  balance.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import Foundation

func extractBalance(index: Int, message: String, length: Int) -> String {
    var balance = ""
    var sawNumber = false
    var invalidCharCount = 0
    var char = ""
    var start = index
    
    while start < length {
        char = String(message[message.index(message.startIndex, offsetBy: start)])
        
        if char >= "0" && char <= "9" {
            sawNumber = true
            balance += char
        } else if sawNumber {
            if char == "." {
                if invalidCharCount == 1 {
                    break
                } else {
                    balance += char
                    invalidCharCount += 1
                }
            } else if char != "," {
                break
            }
        }
        start += 1
    }
    
    return balance
}

func findNonStandardBalance(message: String, keyWordType: IBalanceKeyWordsType = .AVAILABLE) -> String? {
    let balanceKeywords = keyWordType == .AVAILABLE ? availableBalanceKeywords : outstandingBalanceKeywords
    let balKeywordRegex = "(" + balanceKeywords.joined(separator: "|") + ")"
    let amountRegex = "([\\d]+\\.[\\d]+|[\\d]+)"
    var regex: NSRegularExpression
    var matches: [NSTextCheckingResult]?
    var balance: String?
    
    regex = try! NSRegularExpression(pattern: "\(balKeywordRegex)\\s*\(amountRegex)", options: [.caseInsensitive])
    matches = regex.matches(in: message, options: [], range: NSRange(location: 0, length: message.utf16.count))
    if let match = matches?.first {
        balance = (message as NSString).substring(with: match.range(at: 2))
        if let balance = balance, let _ = Double(balance) {
            return balance
        }
    }
    
    regex = try! NSRegularExpression(pattern: "\(amountRegex)\\s*\(balKeywordRegex)", options: [.caseInsensitive])
    matches = regex.matches(in: message, options: [], range: NSRange(location: 0, length: message.utf16.count))
    if let match = matches?.first {
        balance = (message as NSString).substring(with: match.range(at: 1))
        if let balance = balance, let _ = Double(balance) {
            return balance
        }
    }
    
    return nil
}

func getBalance(processedMessage: TMessageType, keyWordType: IBalanceKeyWordsType = .AVAILABLE) -> String? {
    let messageString = processedMessage.joined(separator: " ")
    var indexOfKeyword = -1
    var balance = ""
    
    let balanceKeywords = keyWordType == .AVAILABLE ? availableBalanceKeywords : outstandingBalanceKeywords
    
    for word in balanceKeywords {
        if let range = messageString.range(of: word) {
            indexOfKeyword = messageString.distance(from: messageString.startIndex, to: range.lowerBound)
            break
        }
    }
    
    guard indexOfKeyword != -1 else {
        return nil
    }
    
    var index = indexOfKeyword
    var indexOfRs = -1
    var nextThreeChars = String(messageString.suffix(from: messageString.index(messageString.startIndex, offsetBy: index)).prefix(3))
    index += 3
    
    while index < messageString.count {
        guard index + 1 < messageString.count else {
            break
        }
        nextThreeChars = String(nextThreeChars.suffix(2) + String(messageString[messageString.index(messageString.startIndex, offsetBy: index)]))
        if nextThreeChars == "rs." {
            indexOfRs = index + 1
            break
        }
        index += 1
    }
    
    if indexOfRs == -1 {
        if let balance = findNonStandardBalance(message: messageString) {
            return padCurrencyValue(balance)
        }
        return nil
    }
    
    balance = extractBalance(index: indexOfRs, message: messageString, length: messageString.count)
    
    return padCurrencyValue(balance)
}

