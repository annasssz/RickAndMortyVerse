//
//  EpisodeExpandButtonCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

class EpisodeExpandButtonCell: UICollectionViewCell {
  static let identifier = "EpisodeExpandButtonCell"
  
  private lazy var expandButton: UIButton = {
    let button = UIButton()
    button.setTitle("Episode", for: .normal)
    button.setTitleColor(.black, for: .normal)
    // Add action for button tap to handle expansion/collapse
    button.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
    return button
  }()
  
  var expandAction: (() -> Void)?
  
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
    [expandButton].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      contentView.addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      expandButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      expandButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      expandButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      expandButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
    ])
    
  }
  
  @objc private func expandButtonTapped() {
    expandAction?()
  }
}

