//
//  CharacterItem.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

struct CharacterItem: Decodable {
  let id: Int
  let name: String
  let status: String
  let species: String
  let gender: String
  let location: Location
  let image: String
}
