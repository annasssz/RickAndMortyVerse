//
//  CharacterItemCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import UIKit

enum CharacterStatus: String {
  case alive
  case dead
  case unknown
  
  var color: UIColor {
    switch self {
    case .alive:
      return .green
    case .dead:
      return .red
    case .unknown:
      return .orange
    }
  }
}

class CharacterItemCell: UICollectionViewCell {
  static let identifier = "CharacterItemCell"

  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = UIColor.steelBlueColor
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: 16, weight: .semibold)
    return label
  }()
  
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = UIColor.slateGrayColor
    label.font = .systemFont(ofSize: 14, weight: .semibold)
    return label
  }()
  
  private lazy var statusView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 5
    view.translatesAutoresizingMaskIntoConstraints = false
    view.widthAnchor.constraint(equalToConstant: 10).isActive = true
    view.heightAnchor.constraint(equalToConstant: 10).isActive = true
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [statusView, statusLabel])
    stackView.axis = .horizontal
    stackView.spacing = 8
    return stackView
  }()
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 8
    imageView.clipsToBounds = true
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  override func layoutSublayers(of layer: CALayer) {
    super.layoutSublayers(of: layer)
    applyBorder()
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
      imageView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      imageView.heightAnchor.constraint(equalToConstant: 150),
      
      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
    ])
  }
  
  private func applyBorder() {
    layer.borderWidth = 1
    layer.borderColor = UIColor.systemGray3.cgColor
    layer.cornerRadius = 8
  }
  
  func configure(character: CharacterItem) {
    nameLabel.text = character.name
    statusLabel.text = character.status
    
    setImage(with: character.image)

    if let status = CharacterStatus(rawValue: character.status.lowercased()) {
      statusView.backgroundColor = status.color
    } else {
      statusView.backgroundColor = .clear
    }
  }
  
  private func setImage(with image: String) {
    guard let url = URL(string: image) else { return }

    imageView.load(url: url)
  }
}
