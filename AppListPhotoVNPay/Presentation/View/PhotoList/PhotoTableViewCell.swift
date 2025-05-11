//
//  PhotoTableViewCell.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
  private let photoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit // Giữ tỷ lệ ảnh
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let authorLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let sizeLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.image = nil
    authorLabel.text = nil
    sizeLabel.text = nil
  }
  
  func configure(with photo: Photo) {
    photoImageView.loadImage(from: photo.download_url)
    authorLabel.text = photo.author
    sizeLabel.text = "Size: \(photo.width)x\(photo.height)"
  }
  
  private func setupUI() {
    contentView.addSubview(photoImageView)
    contentView.addSubview(authorLabel)
    contentView.addSubview(sizeLabel)
    
    NSLayoutConstraint.activate([
      photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
      photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      photoImageView.bottomAnchor.constraint(lessThanOrEqualTo: authorLabel.topAnchor, constant: -12),
      
      authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      authorLabel.heightAnchor.constraint(equalToConstant: 24.0),
      authorLabel.bottomAnchor.constraint(equalTo: sizeLabel.topAnchor, constant: -8),
      
      sizeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      sizeLabel.heightAnchor.constraint(equalToConstant: 14.0),
      sizeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      sizeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
    ])
  }
}

