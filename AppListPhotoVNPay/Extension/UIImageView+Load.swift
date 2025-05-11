//
//  UIImageView+Load.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit
import ObjectiveC

private var imageURLKey: UInt8 = 0

final class ImageCache {
  static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
  private var currentURL: String? {
    get { objc_getAssociatedObject(self, &imageURLKey) as? String }
    set { objc_setAssociatedObject(self, &imageURLKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }
  
  func loadImage(from urlString: String) {
    self.currentURL = urlString
    self.image = nil
    
    // Check cache trước
    if let cachedImage = ImageCache.shared.object(forKey: urlString as NSString) {
      self.image = cachedImage
      return
    }
    
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
      guard let self = self,
            let data = data,
            let image = UIImage(data: data),
            self.currentURL == urlString else { return }
      
      // Cache lại ảnh
      ImageCache.shared.setObject(image, forKey: urlString as NSString)
      
      DispatchQueue.main.async {
        self.image = image
      }
    }.resume()
  }
}
