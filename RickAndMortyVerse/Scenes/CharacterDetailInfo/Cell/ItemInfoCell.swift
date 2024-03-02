//
//  ItemInfoCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

class ItemInfoCell: UICollectionViewCell  {
  static let identifier = String(describing: ItemInfoCell.self)
  
  private lazy var imageBackgroundView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = ViewValues.defaultHeightImage / 2
    view.addSubview(imageView)
    view.addSubview(statusView)
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = ViewValues.defaultHeightImage / 2
    return view
  }()
  
  private lazy var statusLabel: UILabel = {
    let view = UILabel()
    view.textColor = UIColor.white
    view.textAlignment = .center
    view.font = .systemFont(ofSize: ViewValues.smallSize, weight: .bold)
    return view
  }()
  
  private lazy var statusView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = ViewValues.defaultStatusViewCornerRadius
    view.addSubview(statusLabel)
    return view
  }()
  
  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.textColor = UIColor.textColor
    view.numberOfLines = ViewValues.multiplierTwo
    view.font = .systemFont(ofSize: ViewValues.doubleSize, weight: .medium)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    applyBorder()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with item: CharacterItem) {
    if let url = URL(string: item.image) {
      imageView.load(url: url) { [weak self] loadedImage in
        self?.imageView.image = loadedImage
      }
    }
    
    statusLabel.text = item.status.rawValue
    nameLabel.text = item.name

    statusView.backgroundColor = item.status.color
    imageBackgroundView.backgroundColor = item.status.color
  }

  private func applyBorder() {
    layer.borderWidth = ViewValues.borderWidth
    layer.cornerRadius = ViewValues.defaultCornerRadius
    layer.borderColor = UIColor.systemGray3.cgColor
  }
  
  private func setupUI() {
    [imageBackgroundView, nameLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    [imageView, statusView,statusLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewValues.defaultPadding),
      imageBackgroundView.heightAnchor.constraint(equalToConstant: ViewValues.defaultHeightImage),
      imageBackgroundView.widthAnchor.constraint(equalToConstant: ViewValues.defaultHeightImage),
      imageBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
      
      imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: ViewValues.smallPadding),
      imageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: ViewValues.smallPadding),
      imageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: -ViewValues.smallPadding),
      imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -ViewValues.smallPadding),
      
      statusView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: ViewValues.defaultPadding),
      statusView.centerXAnchor.constraint(equalTo: centerXAnchor),
      statusView.widthAnchor.constraint(equalToConstant: ViewValues.defaultStatusViewWidth),
      statusView.heightAnchor.constraint(equalToConstant: ViewValues.defaultStatusViewWidth/3),
      
      statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor),
      statusLabel.centerXAnchor.constraint(equalTo: statusView.centerXAnchor),
      
      nameLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
}
