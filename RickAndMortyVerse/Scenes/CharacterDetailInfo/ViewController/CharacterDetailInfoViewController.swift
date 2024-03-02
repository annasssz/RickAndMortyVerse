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
  
  init(id: Int) {
    viewModel = .init(id: id)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
    setupBindings()
    largeTitleDisplayMode()
    setupColectionView()
  }
  
  private func setupBindings() {
    viewModel.dataState
      .bind { [weak self] state in
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
  
  private func largeTitleDisplayMode() {
    self.navigationItem.largeTitleDisplayMode = .never
  }
  
  private func setupColectionView() {
    view.addSubview(collectionView)
    
    collectionView.register(ItemInfoCell.self, forCellWithReuseIdentifier: ItemInfoCell.identifier)
    collectionView.register(AdditionalDetailCell.self, forCellWithReuseIdentifier: AdditionalDetailCell.identifier)
    collectionView.register(EpisodeCell.self, forCellWithReuseIdentifier: EpisodeCell.identifier)
    
    collectionView.frame = view.bounds
    collectionView.dataSource = self
  }
  
  func createLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
      switch sectionIndex {
      case 0:
        return createLayoutForCell(withHeight: ViewValues.heightDimension)
      case 1:
        return createLayoutForCell(withHeight: ViewValues.defaultHeightCell)
      default:
        return createLayoutForCell(withHeight: CGFloat(CGFloat(self.viewModel.episodes.count) * ViewValues.defaultHeightCell))
      }
    }
    
    return layout
  }
}

func createLayoutForCell(withHeight height: CGFloat) -> NSCollectionLayoutSection {
  let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ViewValues.fractionalWidth),
                                        heightDimension: .estimated(height))
  let item = NSCollectionLayoutItem(layoutSize: itemSize)
  
  let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ViewValues.fractionalWidth),
                                         heightDimension: .estimated(height))
  let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
  group.interItemSpacing = .fixed(ViewValues.doublePadding)
  
  let section = NSCollectionLayoutSection(group: group)
  section.interGroupSpacing = ViewValues.normalPadding
  section.contentInsets = NSDirectionalEdgeInsets(top: ViewValues.defaultPadding,
                                                  leading: ViewValues.defaultPadding,
                                                  bottom: ViewValues.defaultPadding,
                                                  trailing: ViewValues.defaultPadding)
  
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
        detailCell.configure(description: "GENDER:", text: viewModel.characterItem?.gender)
      case 1:
        detailCell.configure(description: "SPECIES:", text: viewModel.characterItem?.species)
      case 2:
        detailCell.configure(description: "STATUS:", text: viewModel.characterItem?.status.rawValue)
      default:
        break
      }
      
      return detailCell
    default:
      guard let episodeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodeCell", for: indexPath) as? EpisodeCell else {
        return UICollectionViewCell()
      }
      episodeCell.configure(viewModel.episodes)
      episodeCell.didselect = { [weak self] id in
        guard let self else { return }
        let detailViewController = CharacterDetailInfoViewController(id: id)
        self.navigationController?.pushViewController(detailViewController, animated: true)
      }
      return episodeCell
    }
  }
}
