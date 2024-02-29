//
//  CharacterItemCell.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import UIKit

class CharacterItemCell: UICollectionViewCell {
  static let identifier = "CheracterItemCell"
  
  let textLabel: UILabel = {
    let view = UILabel()
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFit
    view.textColor = .black
    view.numberOfLines = 2
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(textLabel)
    textLabel.frame = bounds
  }
  
  func configure(cheracter: CharacterItem) {
    textLabel.text = cheracter.name
    backgroundColor = .red
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
