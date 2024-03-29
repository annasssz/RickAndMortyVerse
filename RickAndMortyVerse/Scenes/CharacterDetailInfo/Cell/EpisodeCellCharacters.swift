//
//  EpisodeCellCharacters.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

class EpisodeCellCharacters: UICollectionViewCell {
  static let identifier = String(describing: EpisodeCellCharacters.self)
  
  private var characterId: Int? {
    didSet {
      guard let characterId = characterId else {
        imageView.image = nil
        return
      }
      setImage(for: characterId)
    }
  }
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = ViewValues.defaultCornerRadius
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(characterId: Int) {
    self.characterId = characterId
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  private func setupUI() {
    [imageView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }
  
  private func setImage(for characterId: Int) {
    imageView.loadAvatar(characterId: characterId){ [weak self] loadedImage in
      if characterId == self?.characterId {
        self?.imageView.image = loadedImage
      }
    }
  }
}
