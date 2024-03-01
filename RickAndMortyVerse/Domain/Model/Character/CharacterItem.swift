//
//  CharacterItem.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import UIKit

struct CharacterItem: Decodable {
  let id: Int
  let name: String
  let status: CharacterStatus
  let species: String
  let gender: String
  let location: Location
  let image: String
}

enum CharacterStatus: String, Codable {
  case alive = "Alive"
  case dead = "Dead"
  case unknown
  
  var color: UIColor {
    switch self {
    case .alive:
      return .green
    case .dead:
      return .red
    case .unknown:
      return .orange
    }
  }
}
