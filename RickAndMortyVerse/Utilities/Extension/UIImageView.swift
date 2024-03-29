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
  
  func loadAvatar(characterId: Int, completion: @escaping (UIImage?) -> Void) {
    let urlPath = "https://rickandmortyapi.com/api/character/avatar/\(characterId).jpeg"
    guard let url = URL(string: urlPath) else { return }
    load(url: url, completion: completion)
  }
}
