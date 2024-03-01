//
//  AdditionalDetailCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

class AdditionalDetailCell: UICollectionViewCell  {
  static let identifier = "AdditionalDetailCell"
  
  private lazy var genderLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.text = "GENDER" //წასაშლელი
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.systemGray3.cgColor
    view.layer.cornerRadius = 8
    view.textColor = .black
    view.numberOfLines = 2
    view.font = .systemFont(ofSize: 16, weight: .semibold)
    return view
  }()
  
  private lazy var genderInfoLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    view.text = "Male" //წასაშლელი
    view.textColor = UIColor.steelBlueColor
    view.numberOfLines = 2
    view.font = .systemFont(ofSize: 16, weight: .semibold)
    return view
  }()
  
  private lazy var genderStackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [genderLabel, genderInfoLabel])
    view.axis = .horizontal
    view.layer.cornerRadius = 8
    view.spacing = 8
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    applyBorder()
  }
  
  private func applyBorder() {
    layer.borderWidth = 1
    layer.borderColor = UIColor.systemGray3.cgColor
    layer.cornerRadius = 8
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    [genderStackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      genderStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      genderStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      genderStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
      genderStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
    ])
  }
}