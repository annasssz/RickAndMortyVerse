//
//  CharacterItemCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import UIKit

class CharacterItemCell: UICollectionViewCell {
  static let identifier = "CharacterItemCell"
  
  private lazy var nameLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .black
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: 14)
    return label
  }()
  
  private lazy var statusLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .gray
    label.font = .systemFont(ofSize: 14)
    return label
  }()
  
  private let statusView: UIView = {
    let view = UIView()
    view.backgroundColor = .green
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
    imageView.layer.cornerRadius = 10
    imageView.clipsToBounds = true
    imageView.image = UIImage(named: "hi")
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
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
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      imageView.heightAnchor.constraint(equalToConstant: 110),
      
      nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      
      stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
    ])
  }
  
  private func applyBorder() {
    layer.borderWidth = 1
    layer.borderColor = UIColor.systemGray3.cgColor
    layer.cornerRadius = 10
  }
  
  func configure(character: CharacterItem) {
    nameLabel.text = character.name
    statusLabel.text = character.status
  }
}
