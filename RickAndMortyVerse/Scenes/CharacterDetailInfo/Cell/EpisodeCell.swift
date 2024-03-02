//
//  EpisodeCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

struct Episode {
  let title: String
  let characters: [Int]
  var isCollapsed: Bool = true
}

var episodes: [Episode] = [
  .init(title: "Episode 1", characters: [1,2,3,4,5,6,7,8,9,9,9,9,9,9]),
  .init(title: "Episode 2", characters: [1,2]),
  .init(title: "Episode 2", characters: [1,2]),
  .init(title: "Episode 3", characters: [1,2,3,4,5,6,7,8]),
]

class EpisodeCell: UICollectionViewCell, UICollectionViewDataSource {
  static let identifier = String(describing: EpisodeCell.self)
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: createLayout()
  )
  
  private lazy var episodeLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.text = "Episode"
    view.textColor = UIColor.steelBlueColor
    view.numberOfLines = 2
    view.font = .systemFont(ofSize: 24, weight: .semibold)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    [collectionView, episodeLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    collectionView.register(EpisodeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeHeaderView.reuseIdentifier)
    collectionView.register(EpisodeCellCharacters.self, forCellWithReuseIdentifier: EpisodeCellCharacters.identifier)
    
    collectionView.dataSource = self
    
    NSLayoutConstraint.activate([
      episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      episodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      
      collectionView.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 10),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
    ])
  }
  
  func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(150))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(150), heightDimension: .absolute(150))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [header]
      
      return section
    }
    return layout
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    episodes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    episodes[section].isCollapsed ? 0 : episodes[section].characters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCellCharacters", for: indexPath)
    cell.backgroundColor = .red
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeHeaderView.reuseIdentifier, for: indexPath) as! EpisodeHeaderView
    header.configure(with: episodes[indexPath.section].title)
    header.onSelect = {
      print(indexPath.section)
      
      episodes[indexPath.section].isCollapsed.toggle()
      collectionView.reloadSections(IndexSet(integer: indexPath.section))
    }
    
    return header
  }
}
