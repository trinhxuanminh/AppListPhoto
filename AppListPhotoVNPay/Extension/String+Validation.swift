//
//  String+Validation.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

extension String {
  
  /// Loại bỏ dấu, emoji, ký tự đặc biệt không cho phép & cắt tối đa `maxLength`
  func cleanedForSearch(maxLength: Int) -> String {
    let allowedCharset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*():.,<>/[]?\\").inverted
    
    let noDiacritics = self.folding(options: .diacriticInsensitive, locale: .current)
    let filtered = noDiacritics.unicodeScalars.filter { !allowedCharset.contains($0) }
    let result = String(String.UnicodeScalarView(filtered))
    
    return String(result.prefix(maxLength))
  }
}

