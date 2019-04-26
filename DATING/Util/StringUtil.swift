//
//  StringUtil.swift
//  sst-ios-po
//
//  Created by Zal Zhang on 12/28/16.
//  Copyright © 2016 po. All rights reserved.
//

import UIKit

extension String {
    
    func MD5() -> String{
        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
        return data.MD5().hexedString()
    }

    
    func matchRegex(pattern: String) -> Bool {
        if self.characters.isEmpty {
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [pattern])
        return predicate.evaluate(with: self)
    }
    
    var isValidEmail: Bool {
        return matchRegex(pattern:"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}")
    }
    
    var isValidPassword: Bool {
        return matchRegex(pattern:"[A-Z0-9a-z._%+-]{1,20}")
    }
    
    var isValidCharacter: Bool {
        return matchRegex(pattern:"[A-Za-z]")
    }
    
    var URL: NSURL? {
        return NSURL(string: self)
    }
    
    var Base64: String {
        let utf8EncodeData:NSData! = self.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData!
        let base64EncodedString = utf8EncodeData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64EncodedString
    }

    var URLEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
    }
    
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    var isValidInteger: Bool {
        return matchRegex(pattern: "^[0-9]\\d*$")
    }
    
    var isValidPositiveInteger: Bool {
        return matchRegex(pattern: "^[1-9]\\d*$")
    }
    
    var isValidZipCode:Bool {
        return matchRegex(pattern: "[1-9]\\d{4}")
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func strikeThrough() -> NSMutableAttributedString {
        let attributedStr = NSMutableAttributedString(string: self)
        attributedStr.addAttributes([NSStrikethroughStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue], range: NSMakeRange(0, validInt(self.characters.count)))
        return attributedStr
    }
    
    func toAttributedString() -> NSAttributedString {
        var attributedString = NSMutableAttributedString()
        let utf8EncodeData0:NSData! = ("\(self)").data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData!
        do {
            attributedString = try NSMutableAttributedString(data: utf8EncodeData0 as Data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
            let normalAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 14)]
            attributedString.addAttributes(normalAttributes, range: NSMakeRange(0 , attributedString.length))
        } catch {
            attributedString = NSMutableAttributedString(string: "")
            printDebug("SSTMessage, failed to generate attributed string.")
        }
        return attributedString
    }
    
    func sub(start: Int, end: Int) -> String {
        guard start >= 0 && start < characters.count && start <= end else { return "" }
        let startIndex = self.characters.index(self.characters.startIndex, offsetBy: start)
        let endIndex = self.characters.index(self.characters.startIndex, offsetBy: end)
        return self[startIndex...endIndex]
    }
    
    func escapeHtml() -> String {
        var vStr = self
        
        for _ in 0 ... 10000 {
            if vStr.contains("<") && vStr.contains(">") {
                let range = Range(vStr.range(of: "<")!.lowerBound ..< vStr.range(of: ">")!.upperBound)
                vStr.replaceSubrange(range, with: "")
            } else {
                break
            }
        }
        return vStr
    }
    
    func sizeByWidth(font: NSInteger, width: CGFloat) -> CGSize {
        let font = UIFont.systemFont(ofSize: CGFloat(font + 2))
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy()]
        let rect = self.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
        return rect.size
    }
    
    //数组拼接成字符串
    func montageString(array: [String]) -> String {
        let str = ""
        
        return str
    }
}


extension Int
{
    func hexedString() -> String
    {
        return NSString(format:"%02x", self) as String
    }
}

extension NSData
{
    func hexedString() -> String
    {
        var string = String()
        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
        for i in UnsafeBufferPointer<UInt8>(start:unsafePointer, count: length)
        {
            string += Int(i).hexedString()
        }
        return string
    }
    func MD5() -> NSData
    {
        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
        return NSData(data: result as Data)
    }
}
//extension String: URLStringConvertible {
//    public var URLString: String {
//        return self
//    }
//}
//
//extension NSString: URLStringConvertible {
//    public var URLString: String {
//        get {
//            return self as String
//        }
//    }
//}

extension NSAttributedString {
    func addLineSpaceTextAligment(space: CGFloat, textAlignment: NSTextAlignment) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = textAlignment
        
        let rAttributedString = self.mutableCopy() as! NSMutableAttributedString
        rAttributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, self.length))
        return rAttributedString
    }
    
    func addColor(color: UIColor) -> NSAttributedString {
        let rAttributedString = self.mutableCopy() as! NSMutableAttributedString
        rAttributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, self.length))
        return rAttributedString
    }
    
    func addFontSize(size: CGFloat) -> NSAttributedString {
        let rAttributedString = self.mutableCopy() as! NSMutableAttributedString
        rAttributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFont(ofSize: size), range: NSMakeRange(0, self.length))
        return rAttributedString
    }
}
