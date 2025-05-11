//
//  SearchPhotosUseCase.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

class SearchPhotosUseCase {
  private let repository: PhotoRepository
  
  init(repository: PhotoRepository) {
    self.repository = repository
  }
  
  func execute(query: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
    repository.searchPhotos(query: query, completion: completion)
  }
}
