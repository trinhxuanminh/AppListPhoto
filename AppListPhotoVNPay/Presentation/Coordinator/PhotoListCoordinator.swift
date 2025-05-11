//
//  PhotoListCoordinator.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

class PhotoListCoordinator {
  private let window: UIWindow
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    let apiService = APIService()
    let repository = PhotoRepositoryImpl(apiService: apiService)
    let fetchUseCase = FetchPhotosUseCase(repository: repository)
    let searchUseCase = SearchPhotosUseCase(repository: repository)
    let viewModel = PhotoListViewModel(fetchPhotosUseCase: fetchUseCase, searchPhotosUseCase: searchUseCase)
    let viewController = PhotoListViewController(viewModel: viewModel)
    let nav = UINavigationController(rootViewController: viewController)
    window.rootViewController = nav
    window.makeKeyAndVisible()
  }
}
