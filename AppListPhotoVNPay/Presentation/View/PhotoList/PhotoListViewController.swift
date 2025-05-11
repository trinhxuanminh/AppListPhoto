//
//  PhotoListViewController.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

final class PhotoListViewController: UIViewController {
  private let tableView = UITableView()
  private let searchBar = UISearchBar()
  private var photos: [Photo] = []
  private let viewModel: PhotoListViewModel
  
  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .gray)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  init(viewModel: PhotoListViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
    viewModel.loadPhotos(isRefresh: true) // Load ảnh ban đầu
  }
  
  private func setupUI() {
    title = "Picsum Photos"
    view.backgroundColor = .black
    
    searchBar.placeholder = "Search by author or id"
    searchBar.delegate = self
    searchBar.autocapitalizationType = .none
    searchBar.returnKeyType = .done
    
    view.addSubviews(searchBar, tableView, activityIndicator)
    
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    
    tableView.register(PhotoTableViewCell.self)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    
    // Refresh Control
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  private func bindViewModel() {
    viewModel.onPhotosUpdated = { [weak self] photos in
      self?.photos = photos
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
    
    viewModel.onError = { [weak self] errorMessage in
      DispatchQueue.main.async {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self?.present(alert, animated: true)
      }
    }
    
    viewModel.onLoadingStateChanged = { [weak self] isLoading in
      DispatchQueue.main.async {
        if isLoading {
          self?.activityIndicator.startAnimating() // Hiển thị loading
        } else {
          self?.activityIndicator.stopAnimating() // Ẩn loading
          self?.tableView.refreshControl?.endRefreshing() // Kết thúc refresh khi xong
        }
      }
    }
  }
  
  @objc private func refreshData() {
    viewModel.loadPhotos(isRefresh: true)
  }
}

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return photos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: PhotoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
    let photo = photos[indexPath.row]
    cell.configure(with: photo)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let photo = photos[indexPath.row]
    let cellWidth = tableView.frame.width - 24 // Chiều rộng cell trừ padding
    return cellWidth / CGFloat(photo.width) * CGFloat(photo.height) + 82 // Cộng thêm 82 để cho authorLabel và sizeLabel, space
  }
  
  // Load more khi người dùng cuộn tới cuối
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == photos.count - 1 {
      viewModel.loadPhotos(isRefresh: false) // Load more
    }
  }
}

extension PhotoListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    let cleanText = searchText.cleanedForSearch(maxLength: 15)
    if cleanText != searchText {
      searchBar.text = cleanText
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let keyword = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !keyword.isEmpty else {
      viewModel.loadPhotos(isRefresh: true)
      return
    }
    
    let validated = keyword.cleanedForSearch(maxLength: 15)
    searchBar.text = validated
    viewModel.searchPhotos(query: validated)
    searchBar.resignFirstResponder()
  }
}
