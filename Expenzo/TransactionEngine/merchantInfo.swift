//
//  merchantInfo.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import Foundation

func extractMerchantInfo(_ processedMessage: TMessageType) -> (merchant: String?, referenceNo: String?) {
    let messageString = processedMessage.joined(separator: " ")
    var transactionDetails: (merchant: String?, referenceNo: String?) = (nil, nil)
    
    if processedMessage.contains("vpa") {
        if let idx = processedMessage.firstIndex(of: "vpa"), idx < processedMessage.count - 1 {
            let nextStr = processedMessage[idx + 1]
            let name = nextStr.replacingOccurrences(of: #"[\(\)]"#, with: " ", options: .regularExpression).components(separatedBy: .whitespaces).first
            transactionDetails.merchant = name
        }
    }
    
    var match = ""
    for keyword in upiKeywords {
        if let idx = messageString.range(of: keyword)?.lowerBound {
            match = String(messageString[idx...])
        }
    }
    
    if !match.isEmpty {
        let nextWord = getNextWords(messageString, match)
        if isNumber(nextWord) {
            transactionDetails.referenceNo = nextWord
        } else if let merchant = transactionDetails.merchant {
            let longestNumeric = nextWord.components(separatedBy: CharacterSet.decimalDigits.inverted).sorted(by: { $0.count > $1.count }).first
            if let longestNumeric = longestNumeric {
                transactionDetails.referenceNo = longestNumeric
            }
        } else {
            transactionDetails.merchant = nextWord
        }
    }
    
    return transactionDetails
}
