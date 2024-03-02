//
//  AdditionalDetailCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

class AdditionalDetailCell: UICollectionViewCell  {
  static let identifier = String(describing: AdditionalDetailCell.self)
  
  private lazy var descriptionLabel: UILabel = {
    let view = UILabel()
    view.backgroundColor = .systemGray6
    view.clipsToBounds = true
    view.textAlignment = .center
    view.textColor = UIColor.slateGrayColor
    view.font = .systemFont(ofSize: 16, weight: .semibold)
    view.layer.borderWidth = 1
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.systemGray3.cgColor
    return view
  }()
  
  private lazy var infoLabel: UILabel = {
    let view = UILabel()
    view.backgroundColor = .systemGray6
    view.clipsToBounds = true
    view.textAlignment = .center
    view.textColor = UIColor.steelBlueColor
    view.numberOfLines = 2
    view.font = .systemFont(ofSize: 16, weight: .semibold)
    view.layer.borderWidth = 1
    view.layer.cornerRadius = 8
    view.layer.borderColor = UIColor.systemGray3.cgColor
    return view
  }()
  
  private lazy var genderStackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [descriptionLabel, infoLabel])
    view.spacing = 8
    view.axis = .horizontal
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  func configure(description: String, text: String) {
    descriptionLabel.text = description
    infoLabel.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    [genderStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    [descriptionLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      descriptionLabel.widthAnchor.constraint(equalToConstant: 100),
      genderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      genderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      genderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      genderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
    ])
  }
}
