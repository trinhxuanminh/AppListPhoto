//
//  UITableView+Register.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

extension UITableView {
  
  // Đăng ký cell bằng class
  func register<T: UITableViewCell>(_ cellClass: T.Type) {
    let identifier = String(describing: cellClass)
    self.register(cellClass, forCellReuseIdentifier: identifier)
  }
  
  // Đăng ký cell bằng nib
  func registerNib<T: UITableViewCell>(_ cellClass: T.Type) {
    let identifier = String(describing: cellClass)
    let nib = UINib(nibName: identifier, bundle: nil)
    self.register(nib, forCellReuseIdentifier: identifier)
  }
  
  // Dequeue cell với kiểu an toàn
  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
    let identifier = String(describing: T.self)
    guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
      fatalError("❌ Could not dequeue cell with identifier: \(identifier)")
    }
    return cell
  }
}
