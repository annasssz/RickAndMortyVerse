//
//  LoadingFooterView.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import UIKit

class LoadingFooterView: UICollectionReusableView {
  let activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    return activityIndicator
  }()
  
  var isLoading: DataState = .loading {
    didSet {
      switch isLoading {
      case .loading:
        activityIndicatorView.startAnimating()
      default:
        activityIndicatorView.stopAnimating()
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(activityIndicatorView)
    
    NSLayoutConstraint.activate([
      activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
      activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
