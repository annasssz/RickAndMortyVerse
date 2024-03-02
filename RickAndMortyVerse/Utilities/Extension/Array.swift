//
//  Array.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import Foundation

extension Array where Element == String {
  func getIds() -> [Int] {
    compactMap { url -> Int? in
        let components = url.split(separator: "/")
        return components.last.flatMap { Int($0) }
    }
  }
}
