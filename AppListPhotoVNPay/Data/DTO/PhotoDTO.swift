//
//  PhotoDTO.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

struct PhotoDTO: Decodable {
  let id: String
  let author: String
  let width: Int
  let height: Int
  let url: String
  let download_url: String
  
  func toEntity() -> Photo {
    return Photo(
      id: id,
      author: author,
      width: width,
      height: height,
      url: url,
      download_url: download_url
    )
  }
}
