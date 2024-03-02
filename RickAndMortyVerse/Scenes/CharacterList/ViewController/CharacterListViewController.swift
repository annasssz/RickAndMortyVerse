//
//  ViewController.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import UIKit

class CharacterListViewController: UIViewController {
  private let viewModel: CharacterListViewModelType = CharacterListViewModel()
  private lazy var refreshControl = UIRefreshControl()
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: createLayout()
  )
  
  private lazy var searchController: UISearchController = {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Characters"
    return searchController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    setupColectionView()
    setupBindings()
    setupRefreshControl()
    setupSearchBar()
  }
  
  private func setupSearchBar() {
    navigationItem.searchController = searchController
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.title = "Characters"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func setupColectionView() {
    view.addSubview(collectionView)
    
    collectionView.register(CharacterItemCell.self, forCellWithReuseIdentifier: CharacterItemCell.identifier)
    collectionView.register(LoadingFooterView.self, forSupplementaryViewOfKind: "footer", withReuseIdentifier: "LoadingFooterView")
    
    collectionView.frame = view.bounds
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setupBindings() {
    viewModel.dataState
      .bind { [weak self] state in
        self?.refreshControl.endRefreshing()
        
        switch state {
        case .error:
          print("error")
        case .loaded:
          self?.collectionView.reloadData()
        default:
          break
        }
      }
  }
  
  private func setupRefreshControl() {
    refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    collectionView.addSubview(refreshControl)
  }
  
  @objc private func refreshData() {
    viewModel.viewDidLoad()
  }
  
  func createLayout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ViewValues.fractionalWidth / 2),
                                          heightDimension: .absolute(ViewValues.heightDimension))
    
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ViewValues.fractionalWidth),
                                           heightDimension: .absolute(ViewValues.heightDimension))
    
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      subitems: [item, item]
    )
    
    group.interItemSpacing = .fixed(ViewValues.doublePadding)
    
    let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(ViewValues.fractionalWidth),
                                                                               heightDimension: .absolute(ViewValues.heightDimension)),
                                                             elementKind: "footer",
                                                             alignment: .bottom)
    
    let section = NSCollectionLayoutSection(group: group)
    
    section.interGroupSpacing = ViewValues.doublePadding
    section.contentInsets = .init(top: ViewValues.defaultPadding,
                                  leading: ViewValues.defaultPadding,
                                  bottom: ViewValues.defaultPadding,
                                  trailing: ViewValues.defaultPadding)
    section.boundarySupplementaryItems = [footer]
    
    return UICollectionViewCompositionalLayout(section: section)
  }
}

extension CharacterListViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.filteredData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterItemCell.identifier, for: indexPath) as? CharacterItemCell else {
      return UICollectionViewCell(frame: .zero)
    }
    
    cell.configure(character: viewModel.filteredData[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    viewModel.loadMore(index: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: "footer", withReuseIdentifier: "LoadingFooterView", for: indexPath) as? LoadingFooterView else { return UICollectionReusableView() }
    footer.isLoading = viewModel.dataState.value
    return footer
  }
}

extension CharacterListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = viewModel.filteredData[indexPath.row]
    
    let detailViewController = CharacterDetailInfoViewController(id: item.id)
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
}

extension CharacterListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    guard let searchText = searchController.searchBar.text else { return }
    viewModel.filterData(with: searchText)
  }
}
