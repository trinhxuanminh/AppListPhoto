//
//  APIService.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

class APIService {
  func fetchPhotos(page: Int, completion: @escaping (Result<[Photo], Error>) -> Void) {
    let urlStr = APIEndpoint.photos(page: page)
    guard let url = URL(string: urlStr) else { return }
    
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      guard let data = data else { return }
      do {
        let photoDTOs = try JSONDecoder().decode([PhotoDTO].self, from: data)
        let photos = photoDTOs.map { $0.toEntity() }
        completion(.success(photos))
      } catch {
        completion(.failure(error))
      }
    }.resume()
  }
}
