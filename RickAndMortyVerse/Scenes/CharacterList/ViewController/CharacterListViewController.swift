//
//  ViewController.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import UIKit

class CharacterListViewController: UIViewController, UICollectionViewDataSource {
  private let viewModel: CharacterListViewModelType = CharacterListViewModel()
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: createLayout()
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupColectionView()
    viewModel.viewDidLoad()
  }
  
  func setupColectionView() {
    view.addSubview(collectionView)
    
    collectionView.register(CharacterItemCell.self, forCellWithReuseIdentifier: CharacterItemCell.identifier)
    collectionView.frame = view.bounds
    collectionView.dataSource = self
  }
  
  func createLayout() -> UICollectionViewCompositionalLayout {
    // Define Item Size
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(200.0))
    
    // Create Item
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    // Define Group Size to fit two items side by side
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200.0))
    
    // Since we want two items side by side, set the group size width to half
    let group = NSCollectionLayoutGroup.horizontal(
      layoutSize: groupSize,
      repeatingSubitem: item,
      count: 2
    )
    
    group.interItemSpacing = .fixed(16.0)
    
    // Create Section
    let section = NSCollectionLayoutSection(group: group)
    
    section.interGroupSpacing = 16.0
    section.contentInsets = .init(top: 16.0, leading: 16.0, bottom: 16.0, trailing: 16.0)
    
    // Return
    return UICollectionViewCompositionalLayout(section: section)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.data.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterItemCell.identifier, for: indexPath) as? CharacterItemCell else {
      return UICollectionViewCell(frame: .zero)
    }
    
    cell.configure(cheracter: viewModel.data[indexPath.row])
    return cell
  }
}
