//
//  EpisodeHeaderView.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import UIKit

class EpisodeHeaderView: UICollectionReusableView {
  static let reuseIdentifier = String(describing: EpisodeHeaderView.self)
  
  var onSelect: (() -> Void)?
  
  private let episodeNameLabel: UILabel = {
    let view = UILabel()
    view.textAlignment = .left
    view.textColor = UIColor.steelBlueColor
    view.font = .systemFont(ofSize: ViewValues.normalSize, weight: .semibold)
    return view
  }()
  
  private lazy var dotView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = ViewValues.defaultStatusViewCornerRadius
    view.backgroundColor = .steelBlueColor
    view.widthAnchor.constraint(equalToConstant: ViewValues.defaultStatusView).isActive = true
    view.heightAnchor.constraint(equalToConstant: ViewValues.defaultStatusView).isActive = true
    return view
  }()
  
  private lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: [dotView, episodeNameLabel])
    view.axis = .horizontal
    view.alignment = .center
    view.spacing = ViewValues.normalPadding
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
    [stackView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
      stackView.topAnchor.constraint(equalTo: topAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  func configure(with title: String?) {
    episodeNameLabel.text = title
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    onSelect?()
  }
}
