//
//  EpisodeCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

struct Episode {
  let title: String?
  let characters: [Int]
  var isCollapsed: Bool = true
}

class EpisodeCell: UICollectionViewCell {
  static let identifier = String(describing: EpisodeCell.self)
  var didselect: ((Int) -> ())?
  
  private var episodes: [Episode] = [] {
    didSet {
      collectionView.reloadData()
    }
  }
  
  private lazy var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: createLayout()
  )
  
  private lazy var episodeLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.text = "Episode"
    view.textColor = UIColor.textColor
    view.numberOfLines = ViewValues.multiplierTwo
    view.font = .systemFont(ofSize: ViewValues.doubleSize, weight: .medium)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupCollectionView()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure (_ episodes: [Episode]) {
    self.episodes = episodes
  }
  
  private func setupCollectionView() {
    collectionView.register(EpisodeHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EpisodeHeaderView.reuseIdentifier)
    collectionView.register(EpisodeCellCharacters.self, forCellWithReuseIdentifier: EpisodeCellCharacters.identifier)
    
    collectionView.isScrollEnabled = false
    collectionView.dataSource = self
    collectionView.delegate = self
  }
  
  private func setupUI() {
    [collectionView, episodeLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      episodeLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      episodeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      episodeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      collectionView.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: ViewValues.defaultPadding),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  private func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
      
      let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(ViewValues.defaultEpisodeCell), 
                                            heightDimension: .absolute(ViewValues.defaultEpisodeCell))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: ViewValues.defaultPadding,
                                                   leading: ViewValues.defaultPadding,
                                                   bottom: ViewValues.defaultPadding,
                                                   trailing: ViewValues.defaultPadding)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(ViewValues.defaultEpisodeCell),
                                             heightDimension: .absolute(ViewValues.defaultEpisodeCell))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)
      section.orthogonalScrollingBehavior = .continuous
      
      let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ViewValues.fractionalWidth), 
                                              heightDimension: .absolute(ViewValues.defaultHeightCell))
      let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
      section.boundarySupplementaryItems = [header]
      
      return section
    }
    return layout
  }
}

extension EpisodeCell: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    episodes.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    episodes[section].isCollapsed ? 0 : episodes[section].characters.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCellCharacters", for: indexPath) as? EpisodeCellCharacters else { return UICollectionViewCell() }
    cell.configure(characterId: episodes[indexPath.section].characters[indexPath.row])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard kind == UICollectionView.elementKindSectionHeader else {
      return UICollectionReusableView()
    }
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EpisodeHeaderView.reuseIdentifier, for: indexPath) as! EpisodeHeaderView
    header.configure(with: episodes[indexPath.section].title)
    header.onSelect = {
      
      self.episodes[indexPath.section].isCollapsed.toggle()
      collectionView.reloadSections(IndexSet(integer: indexPath.section))
    }
    
    return header
  }
}

extension EpisodeCell: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let id = episodes[indexPath.section].characters[indexPath.row]
    didselect?(id)
  }
}
