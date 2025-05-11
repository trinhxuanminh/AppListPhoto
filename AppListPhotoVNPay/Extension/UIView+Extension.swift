//
//  UIView+Extension.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

extension UIView {
  
  // Thêm nhiều subview cùng lúc
  func addSubviews(_ views: UIView...) {
    views.forEach { addSubview($0) }
  }
  
  // Bo góc mặc định
  func rounded(cornerRadius: CGFloat = 8.0) {
    self.layer.cornerRadius = cornerRadius
    self.layer.masksToBounds = true
  }
  
  // Đổ bóng mặc định
  func dropShadow(
    color: UIColor = .black,
    opacity: Float = 0.1,
    offset: CGSize = CGSize(width: 0, height: 2),
    radius: CGFloat = 4.0
  ) {
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowRadius = radius
    layer.masksToBounds = false
  }
  
  // AutoLayout tiện hơn
  func pinToEdges(of superview: UIView, insets: UIEdgeInsets = .zero) {
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
      leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
    ])
  }
}
