//
//  EpisodeResponse.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import Foundation

struct EpisodeResponse: Decodable {
  let name: String?
  let characters: [String]?
}
