//
//  APIEndpoint.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

enum APIEndpoint {
  static func photos(page: Int, limit: Int = 100) -> String {
    return "https://picsum.photos/v2/list?page=\(page)&limit=\(limit)"
  }
}
