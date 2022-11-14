//
//  NSAttributedString+Hyperlink.swift
//  AR-Calendar
//
//  Created by Denis Beloshitskiy on 11/14/22.
//

import Foundation

extension NSAttributedString {
  static func makeHyperLink(for path: String, in string: String, as substring: String)
    -> NSAttributedString {
    let result = NSMutableAttributedString(string: string)
    let tempString = NSString(string: string)
    let substringRange = tempString.range(of: substring)
    result.addAttribute(.link, value: path, range: substringRange)
    return result
  }
}
