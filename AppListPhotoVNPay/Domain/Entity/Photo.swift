//
//  Photo.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

struct Photo: Decodable {
  let id: String
  let author: String
  let width: Int
  let height: Int
  let url: String
  let download_url: String
}
