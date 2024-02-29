//
//  CharacterCount.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import Foundation

struct PaginationInfo: Decodable {
  let count: Int
  let pages: Int
  let next: String?
  let prev: String?
}
