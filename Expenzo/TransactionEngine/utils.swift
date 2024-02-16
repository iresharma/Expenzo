import Foundation

func isNumber(_ val: Any) -> Bool {
    guard let number = val as? Double else {
        return false
    }
    return !number.isNaN
}

func trimLeadingAndTrailingChars(_ str: String) -> String {
    let first = str.first ?? Character("")
    let last = str.last ?? Character("")

    var finalStr = NumberFormatter().number(from: String(last)) == nil ? String(str.dropLast()) : str
    finalStr = NumberFormatter().number(from: String(first)) == nil ? String(finalStr.dropFirst()) : finalStr

    return finalStr
}

func extractBondedAccountNo(_ accountNo: String) -> String {
    let strippedAccountNo = accountNo.replacingOccurrences(of: "ac", with: "")
    return NumberFormatter().number(from: strippedAccountNo) == nil ? "" : strippedAccountNo
}

func processMessage(_ message: String) -> [String] {
    var messageStr = message.lowercased()
    messageStr = messageStr.replacingOccurrences(of: "-", with: "")
    messageStr = messageStr.replacingOccurrences(of: "!", with: "")
    messageStr = messageStr.replacingOccurrences(of: ":", with: " ")
    messageStr = messageStr.replacingOccurrences(of: "/", with: "")
    messageStr = messageStr.replacingOccurrences(of: "=", with: " ")
    messageStr = messageStr.replacingOccurrences(of: "{", with: " ")
    messageStr = messageStr.replacingOccurrences(of: "}", with: " ")
    messageStr = messageStr.replacingOccurrences(of: "\n", with: " ")
    messageStr = messageStr.replacingOccurrences(of: "\r", with: " ")
    messageStr = messageStr.replacingOccurrences(of: "ending ", with: "")
    messageStr = messageStr.replacingOccurrences(of: "x|[*]", with: "", options: .regularExpression)
    messageStr = messageStr.replacingOccurrences(of: "is ", with: "")
    messageStr = messageStr.replacingOccurrences(of: "with ", with: "")
    messageStr = messageStr.replacingOccurrences(of: "no. ", with: "")
    messageStr = messageStr.replacingOccurrences(of: "\\bac\\b|\\bacct\\b|\\baccount\\b", with: "ac", options: .regularExpression)
    messageStr = messageStr.replacingOccurrences(of: "rs(?=\\w)", with: "rs. ", options: .regularExpression)
    messageStr = messageStr.replacingOccurrences(of: "rs ", with: "rs. ")
    messageStr = messageStr.replacingOccurrences(of: "inr(?=\\w)", with: "rs. ", options: .regularExpression)
    messageStr = messageStr.replacingOccurrences(of: "inr ", with: "rs. ")
    messageStr = messageStr.replacingOccurrences(of: "rs. ", with: "rs.")
    messageStr = messageStr.replacingOccurrences(of: "rs.(?=\\w)", with: "rs. ", options: .regularExpression)

    for combinedWord in combinedWords {
        let range = NSRange(location: 0, length: messageStr.utf16.count)
        messageStr = combinedWord.regex.stringByReplacingMatches(in: messageStr, options: [], range: range, withTemplate: combinedWord.word)
    }

    return messageStr.components(separatedBy: " ").filter { !$0.isEmpty }
}

func padCurrencyValue(_ val: String) -> String {
    let components = val.split(separator: ".")
    let rhs = components.count > 1 ? String(components[1]) : ""
    return "\(components[0]).\(rhs.padding(toLength: 2, withPad: "0", startingAt: 0))"
}

func getNextWords(_ source: String, _ searchWord: String, _ count: Int = 1) -> String {
    guard let range = source.range(of: searchWord) else {
        return ""
    }
    
    let startIndex = range.upperBound
    let endIndex = source.index(startIndex, offsetBy: count, limitedBy: source.endIndex) ?? source.endIndex
    let nextGroup = source[startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines)
    
    return nextGroup
}
