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
    view.font = .systemFont(ofSize: ViewValues.normalSize, weight: .semibold)
    view.layer.borderWidth = ViewValues.borderWidth
    view.layer.cornerRadius = ViewValues.defaultCornerRadius
    view.layer.borderColor = UIColor.systemGray3.cgColor
    return view
  }()
  
  private lazy var infoLabel: UILabel = {
    let view = UILabel()
    view.backgroundColor = .systemGray6
    view.clipsToBounds = true
    view.textAlignment = .center
    view.textColor = UIColor.steelBlueColor
    view.numberOfLines = ViewValues.multiplierTwo
    view.font = .systemFont(ofSize: ViewValues.normalSize, weight: .semibold)
    view.layer.borderWidth = ViewValues.borderWidth
    view.layer.cornerRadius = ViewValues.defaultCornerRadius
    view.layer.borderColor = UIColor.systemGray3.cgColor
    return view
  }()
  
  private lazy var genderStackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [descriptionLabel, infoLabel])
    view.spacing = ViewValues.normalPadding
    view.axis = .horizontal
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  func configure(description: String, text: String?) {
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
      genderStackView.topAnchor.constraint(equalTo: topAnchor),
      genderStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      genderStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      genderStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      descriptionLabel.widthAnchor.constraint(equalToConstant: ViewValues.defaultDescriptionLabelWidth),
    ])
  }
}
