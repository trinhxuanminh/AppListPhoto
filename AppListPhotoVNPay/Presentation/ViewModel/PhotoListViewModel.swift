//
//  PhotoListViewModel.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import Foundation

final class PhotoListViewModel {
  private let fetchPhotosUseCase: FetchPhotosUseCase
  private let searchPhotosUseCase: SearchPhotosUseCase
  
  var onPhotosUpdated: (([Photo]) -> Void)?
  var onError: ((String) -> Void)?
  var onLoadingStateChanged: ((Bool) -> Void)? // dùng cho pull-to-refresh
  var onPaginationLoadingChanged: ((Bool) -> Void)? // dùng cho load-more
  
  private(set) var currentPage: Int = 1
  private var isLoading = false
  private(set) var photos: [Photo] = []
  private var hasMorePages = true
  private var isSearching = false
  
  init(fetchPhotosUseCase: FetchPhotosUseCase, searchPhotosUseCase: SearchPhotosUseCase) {
    self.fetchPhotosUseCase = fetchPhotosUseCase
    self.searchPhotosUseCase = searchPhotosUseCase
  }
  
  func loadPhotos(isRefresh: Bool = false) {
    guard !isLoading else { return }
    
    if isRefresh {
      currentPage = 1
      hasMorePages = true
      onLoadingStateChanged?(true)
    } else {
      onPaginationLoadingChanged?(true)
    }
    
    isLoading = true
    fetchPhotosUseCase.execute(page: currentPage) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      self.onLoadingStateChanged?(false)
      self.onPaginationLoadingChanged?(false)
      
      switch result {
      case .success(let newPhotos):
        if isRefresh {
          self.photos = newPhotos
        } else {
          self.photos += newPhotos
        }
        
        if newPhotos.count < 100 {
          self.hasMorePages = false
        } else {
          self.currentPage += 1
        }
        
        self.onPhotosUpdated?(self.photos)
        
      case .failure(let error):
        self.onError?(error.localizedDescription)
      }
    }
  }
  
  func loadMoreIfNeeded(index: Int) {
    guard !isSearching, hasMorePages, !isLoading, index == photos.count - 1 else { return }
    loadPhotos()
  }
  
  func refreshPhotos() {
    isSearching = false
    loadPhotos(isRefresh: true)
  }
  
  func searchPhotos(query: String) {
    isLoading = true
    isSearching = true
    currentPage = 1
    onLoadingStateChanged?(true)
    
    searchPhotosUseCase.execute(query: query) { [weak self] result in
      guard let self = self else { return }
      self.isLoading = false
      self.onLoadingStateChanged?(false)
      
      switch result {
      case .success(let searchedPhotos):
        self.photos = searchedPhotos
        self.onPhotosUpdated?(searchedPhotos)
      case .failure(let error):
        self.onError?(error.localizedDescription)
      }
    }
  }
}

