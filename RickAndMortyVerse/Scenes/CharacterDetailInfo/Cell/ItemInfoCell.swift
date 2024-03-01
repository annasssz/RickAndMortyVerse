//
//  ItemInfoCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

class ItemInfoCell: UICollectionViewCell  {
  static let identifier = "ItemInfoCell"
  
  private lazy var imageBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .green //წაშაშლელი
    view.layer.cornerRadius = 125
    view.addSubview(imageView)
    view.addSubview(statusView)
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = 125
    return view
  }()
  
  private lazy var statusLabel: UILabel = {
    let view = UILabel()
    view.textColor = UIColor.black
    view.textAlignment = .center
    view.text = "Alive" //წაშაშლელი
    view.font = .systemFont(ofSize: 18, weight: .semibold)
    return view
  }()
  
  private lazy var statusView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 5
    view.backgroundColor = .green
    
    view.widthAnchor.constraint(equalToConstant: 90).isActive = true
    view.heightAnchor.constraint(equalToConstant: 30).isActive = true
    view.addSubview(statusLabel)
    return view
  }()
  
  private lazy var nameLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.textColor = UIColor.black
    view.numberOfLines = 2
    view.text = "Rick Sanchez cluser Princess" //წაშაშლელი
    view.font = .systemFont(ofSize: 24, weight: .semibold)
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
  
  private func applyBorder() {
    layer.borderWidth = 1
    layer.borderColor = UIColor.systemGray3.cgColor
    layer.cornerRadius = 8
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
      imageBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      imageBackgroundView.heightAnchor.constraint(equalToConstant: 250),
      imageBackgroundView.widthAnchor.constraint(equalToConstant: 250),
      imageBackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
      
      imageView.topAnchor.constraint(equalTo: imageBackgroundView.topAnchor, constant: 5),
      imageView.leadingAnchor.constraint(equalTo: imageBackgroundView.leadingAnchor, constant: 5),
      imageView.trailingAnchor.constraint(equalTo: imageBackgroundView.trailingAnchor, constant: -5),
      imageView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: -5),
      
      statusView.bottomAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 10),
      statusView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
      
      statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor, constant: 0),
      statusLabel.centerXAnchor.constraint(equalTo: statusView.centerXAnchor, constant: 0),
      
      nameLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 30),
      nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
    ])
  }
}
