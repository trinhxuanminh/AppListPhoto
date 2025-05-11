//
//  PhotoRepositoryImpl.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

class PhotoRepositoryImpl: PhotoRepository {
  private let apiService: APIService
  
  init(apiService: APIService) {
    self.apiService = apiService
  }
  
  func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
    apiService.fetchPhotos(page: page, completion: completion)
  }
  
  func searchPhotos(query: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
    fetchPhotos(page: 1) { result in
      switch result {
      case .success(let photos):
        let filtered = photos.filter {
          $0.author.lowercased().contains(query.lowercased()) ||
          $0.id.contains(query)
        }
        completion(.success(filtered))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
