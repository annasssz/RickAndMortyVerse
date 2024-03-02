//
//  EpisodeHeaderView.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import UIKit

class EpisodeHeaderView: UICollectionReusableView {
  static let reuseIdentifier = "EpisodeHeaderView"
  
  var onSelect: (() -> Void)?
  
  private let episodeNameLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .center
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    [episodeNameLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      episodeNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      episodeNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      episodeNameLabel.topAnchor.constraint(equalTo: topAnchor),
      episodeNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func configure(with title: String) {
    episodeNameLabel.text = title
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    onSelect?()
  }
}
