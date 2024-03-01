//
//  CharacterDetailInfoViewController.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit
class CharacterDetailInfoViewController: UIViewController {
  private let viewModel: CharacterDetailInfoViewModel

  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: createLayout()
  )
  
  init(item: CharacterItem) {
    viewModel = .init(characterItem: item)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    largeTitleDisplayMode()
    setupColectionView()
  }
  
  func largeTitleDisplayMode() {
    self.navigationItem.largeTitleDisplayMode = .never
  }
  
  func setupColectionView() {
    view.addSubview(collectionView)
    
    collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
    collectionView.register(AdditionalDetailCell.self, forCellWithReuseIdentifier: AdditionalDetailCell.identifier)
    collectionView.register(EpisodeExpandButtonCell.self, forCellWithReuseIdentifier: EpisodeExpandButtonCell.identifier)
    
    collectionView.frame = view.bounds
    collectionView.dataSource = self
  }
  
  func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
      switch sectionIndex {
      case 0:
        return createLayoutForCell(withHeight: 350)
      case 1:
        return createLayoutForCell(withHeight: 30)
      default:
        return createLayoutForCell(withHeight: 50)
      }
    }
    
    return layout
  }
}

func createLayoutForCell(withHeight height: CGFloat) -> NSCollectionLayoutSection {
  let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  
  let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(height))
  let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
  group.interItemSpacing = .fixed(16)
  
  let section = NSCollectionLayoutSection(group: group)
  section.interGroupSpacing = 8
  section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
  
  return section
}

extension CharacterDetailInfoViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      return 3
    default:
      return 1
    }
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      guard let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemInfoCell", for: indexPath) as? ItemInfoCell else {
        return UICollectionViewCell()
      }

      infoCell.configure(with: viewModel.characterItem)
      return infoCell
    case 1:
      guard let detailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalDetailCell", for: indexPath) as? AdditionalDetailCell else {
        return UICollectionViewCell()
      }
      
      switch indexPath.row {
      case 0:
        detailCell.configure(description: "GENDER", text: viewModel.characterItem.gender)
      case 1:
        detailCell.configure(description: "SPECIES", text: viewModel.characterItem.species)
      case 2:
        detailCell.configure(description: "STATUS", text: viewModel.characterItem.status.rawValue)
      default:
        break
      }
      
      return detailCell
    default:
      return collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeExpandButtonCell", for: indexPath) as! EpisodeExpandButtonCell
    }
  }
}
