//
//  PhotoRepository.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

protocol PhotoRepository {
  func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void)
  func searchPhotos(query: String, completion: @escaping (Result<[Photo], Error>) -> Void)
}
