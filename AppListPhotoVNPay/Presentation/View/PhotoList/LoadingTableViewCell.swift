//
//  LoadingTableViewCell.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

final class LoadingTableViewCell: UITableViewCell {
  private let activityIndicator: UIActivityIndicatorView = {
    if #available(iOS 13.0, *) {
      return UIActivityIndicatorView(style: .medium)
    } else {
      return UIActivityIndicatorView(style: .gray)
    }
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    activityIndicator.startAnimating()
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(activityIndicator)
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
