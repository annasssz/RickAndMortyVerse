//
//  UIImageView.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit

extension UIImageView {
  func load(url: URL, completion: @escaping (UIImage?) -> Void ) {
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url) {
        if let image = UIImage(data: data) {
          DispatchQueue.main.async {
            completion(image)
          }
        }
      }
    }
  }
}
