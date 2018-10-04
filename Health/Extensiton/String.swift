//
//  String.swift
//  airCloset
//
//  Created by Shohei Ohno on 2015/11/09.
//  Copyright © 2015年 Gungnir. All rights reserved.
//

import UIKit
import MobileCoreServices

extension String {
    var isEmail: Bool {
        get {
            let regexString = "^(([a-zA-Z0-9]+)(\\.[a-zA-Z0-9_]{1,})*(\\+[a-zA-Z0-9_\\-]{1,})?){1,}@(([a-zA-Z0-9]{2,})(\\.[a-zA-Z]{2,3}){1,2})$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regexString)
            return predicate.evaluate(with: self) && !isContainsEmoji && !isContainsJapaneseCharacter
        }
    }

    var isPassword: Bool {
        get {
            let regexString = "^(?=.*?)(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,32}$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regexString)
            return predicate.evaluate(with: self) && !isContainsEmoji && !isContainsJapaneseCharacter
        }
    }

    var isNickName: Bool {
        get {
            do {
                let regexString = "^[a-zA-Z0-9_.]{1,255}$"
                let regex = try NSRegularExpression(pattern: regexString)
                return regex.firstMatch(in: self,
                                        options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                        range: NSMakeRange(0, NSString(string: self).length)) != nil
            } catch {
                return false
            }
        }
    }

    var isContainsEmoji: Bool {
        get {
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x1F600...0x1F64F, // Emoticons
                 0x1F300...0x1F5FF, // Misc Symbols and Pictographs
                 0x1F680...0x1F6FF, // Transport and Map
                 0x2600...0x26FF, // Misc symbols
                 0x2700...0x27BF, // Dingbats
                 0xFE00...0xFE0F, // Variation Selectors
                 0x1F900...0x1F9FF, // Supplemental Symbols and Pictographs
                 0x1F1E6...0x1F1FF: // Flags
                    return true
                default:
                    continue
                }
            }
            return false
        }
    }

    var isContainsJapaneseCharacter: Bool {
        get {
            for scalar in unicodeScalars {
                switch scalar.value {
                case 0x3040...0x309F, // Japaneses: Hiragana
                 0x30A0...0x30FF, // Japaneses: Katakana
                 0x4E00...0x9FBF, // Japaneses: Kanji
                 0xFF20: // Japaneses: @ character full size
                    return true
                default:
                    continue
                }
            }
            return false
        }
    }

    func isAlphanumeric() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[a-zA-Z0-9_]+").evaluate(with: self)
    }

    // TODO: LoginView変更で削除
    func removeAllHTMLTag() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }

    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).appendingPathComponent(path)
    }

    var localized: String {
        let localized = NSLocalizedString(self, comment: "")
        if !localized.isEmpty {
            return localized
        } else {
            return self
        }
    }

    func isWhiteSpaceOrEmpty() -> Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.height)
    }
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
}

extension Optional where Wrapped == String {
    func isWhiteSpaceOrEmpty() -> Bool {
        return self?.trimmingCharacters(in: .whitespaces).isEmpty ?? true
    }
}
