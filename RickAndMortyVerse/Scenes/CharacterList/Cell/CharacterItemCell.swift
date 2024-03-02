//
//  CharacterItemCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import UIKit

class CharacterItemCell: UICollectionViewCell {
  static let identifier = String(describing: CharacterItemCell.self)
  
  private var character: CharacterItem? {
    didSet{
      guard let character = character else { return }
      self.nameLabel.text = character.name
      self.statusLabel.text = character.status.rawValue
      self.setImage(with: character.image)
      self.statusView.backgroundColor = character.status.color
    }
  }
  
  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.textColor = UIColor.textColor
    view.numberOfLines = ViewValues.multiplierTwo
    view.font = .systemFont(ofSize: ViewValues.defaultSize, weight: .medium)
    return view
  }()
  
  private lazy var statusLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .left
    view.textColor = UIColor.slateGrayColor
    view.font = .systemFont(ofSize: ViewValues.smallSize, weight: .semibold)
    return view
  }()
  
  private lazy var statusView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = ViewValues.defaultStatusViewCornerRadius
    view.widthAnchor.constraint(equalToConstant: ViewValues.defaultStatusView).isActive = true
    view.heightAnchor.constraint(equalToConstant: ViewValues.defaultStatusView).isActive = true
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [statusView, statusLabel])
    view.axis = .horizontal
    view.spacing = ViewValues.normalPadding
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = ViewValues.normalPadding
    view.clipsToBounds = true
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    applyBorder()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = nil
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    [imageView, nameLabel, stackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: ViewValues.defaultPadding),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewValues.defaultPadding),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewValues.defaultPadding),
      imageView.heightAnchor.constraint(equalToConstant: ViewValues.defaultHeightImage),
      
      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: ViewValues.defaultPadding),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewValues.defaultPadding),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewValues.defaultPadding),
      nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -ViewValues.defaultPadding),
      
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewValues.defaultPadding),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewValues.defaultPadding),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -ViewValues.defaultPadding),
    ])
  }
  
  private func applyBorder() {
    layer.borderWidth = ViewValues.borderWidth
    layer.cornerRadius = ViewValues.defaultCornerRadius
    layer.borderColor = UIColor.systemGray3.cgColor
  }
  
  func configure(character: CharacterItem) {
    self.character = character
  }
  
  private func setImage(with image: String) {
    guard let url = URL(string: image) else { return }
    imageView.load(url: url) { [weak self] loadedImage in
      if image == self?.character?.image {
        self?.imageView.image = loadedImage
      }
    }
  }
}
