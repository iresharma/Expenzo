//
//  account.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import Foundation
func getCard(message: [String]) -> IAccountInfo {
    var combinedCardName = ""
    guard let cardIndex = message.firstIndex(where: { word in
        word == "card" ||
        combinedWords.filter({ $0.type == IAccountType.CARD }).contains(where: { w in
            if w.word == word {
                combinedCardName = w.word
                return true
            }
            return false
        })
    }) else {
        return IAccountInfo(type: nil, number: nil, name: nil)
    }
    
    var card: IAccountInfo = IAccountInfo(type: nil, number: nil, name: nil)
    
    if cardIndex != -1 {
        card.number = message[cardIndex + 1]
        card.type = IAccountType.CARD
        
        if let number = card.number, NumberFormatter().number(from: number) == nil {
            return IAccountInfo(type: combinedCardName.isEmpty ? nil : IAccountType.CARD, number: nil, name: combinedCardName)
        }
        
        return card
    }
    
    return IAccountInfo(type: nil, number: nil, name: nil)
}

func getAccount(processedMessage: TMessageType) -> IAccountInfo {
    var accountIndex = -1
    var account: IAccountInfo = IAccountInfo(type: nil, number: nil, name: nil)
    
    for (index, word) in processedMessage.enumerated() {
        if word == "ac" {
            if index + 1 < processedMessage.count {
                let accountNo = trimLeadingAndTrailingChars(processedMessage[index + 1])
                
                if let _ = Double(accountNo) {
                    accountIndex = index
                    account.type = IAccountType.ACCOUNT
                    account.number = accountNo
                    break
                } else {
                    continue
                }
            } else {
                continue
            }
        } else if word.contains("ac") {
            let extractedAccountNo = extractBondedAccountNo(word)
            
            if extractedAccountNo.isEmpty {
                continue
            } else {
                accountIndex = index
                account.type = IAccountType.ACCOUNT
                account.number = extractedAccountNo
                break
            }
        }
    }
    
    if accountIndex == -1 {
        account = getCard(message: processedMessage)
    }
    
    if account.type == nil {
        if let wallet = processedMessage.first(where: { word in wallets.contains(word) }) {
            account.type = IAccountType.WALLET
            account.name = wallet
        }
    }
    
    if account.type == nil {
        if let specialAccount = combinedWords.first(where: { word in
            word.type == IAccountType.ACCOUNT && processedMessage.contains(word.word)
        }) {
            account.type = specialAccount.type
            account.name = specialAccount.word
        }
    }
    
    if let number = account.number, number.count > 4 {
        account.number = String(number.suffix(4))
    }
    
    return account
}
