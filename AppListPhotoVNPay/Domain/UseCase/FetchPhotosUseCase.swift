//
//  FetchPhotosUseCase.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

class FetchPhotosUseCase {
  private let repository: PhotoRepository
  
  init(repository: PhotoRepository) {
    self.repository = repository
  }
  
  func execute(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
    repository.fetchPhotos(page: page, completion: completion)
  }
}
