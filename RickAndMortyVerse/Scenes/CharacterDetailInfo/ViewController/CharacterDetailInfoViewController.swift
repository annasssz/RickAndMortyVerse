//
//  CharacterDetailInfoViewController.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit
class CharacterDetailInfoViewController: UIViewController {
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: createLayout()
  )
  
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
    //      collectionView.delegate = self
  }
  
  func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
      if sectionIndex == 0 {
        return createLayoutForItemInfoCell()
      } else if sectionIndex == 1 {
        return createLayoutForAdditionalDetailCell()
      } else {
        return createLayoutForEpisodeExpandButtonCell()
      }
    }
    
    return layout
  }
}

func createLayoutForItemInfoCell() -> NSCollectionLayoutSection {
  let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  
  let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350))
  let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                               subitem: item,
                                               count: 1)
  
  group.interItemSpacing = .fixed(16)
  
  let section = NSCollectionLayoutSection(group: group)
  section.interGroupSpacing = 16
  section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
  
  return section
}

func createLayoutForAdditionalDetailCell() -> NSCollectionLayoutSection {
  let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  
  let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
  let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                               subitem: item,
                                               count: 1)
  
  group.interItemSpacing = .fixed(16)
  
  let section = NSCollectionLayoutSection(group: group)
  section.interGroupSpacing = 8
  section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
  
  return section
}

func createLayoutForEpisodeExpandButtonCell() -> NSCollectionLayoutSection {
  let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  
  let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
  let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                               subitem: item,
                                               count: 1)
  
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
      return collectionView.dequeueReusableCell(withReuseIdentifier: "ItemInfoCell", for: indexPath) as! ItemInfoCell
    case 1:
      return collectionView.dequeueReusableCell(withReuseIdentifier: "AdditionalDetailCell", for: indexPath) as! AdditionalDetailCell
    default:
      return collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeExpandButtonCell", for: indexPath) as! EpisodeExpandButtonCell
    }
  }
}
