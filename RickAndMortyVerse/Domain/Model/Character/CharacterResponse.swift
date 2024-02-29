//
//  Character.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

struct CharacterResponse: Decodable {
  let info: PaginationInfo
  let results: [CharacterItem]
}
