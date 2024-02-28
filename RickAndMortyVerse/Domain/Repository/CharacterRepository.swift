//
//  CharacterRepository.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

//TODO: REMOVE
struct Void: Decodable {}

class CharacterRepository {
  func getCharacters(page: Int? = nil) async throws -> Void {
    let endpoint = Endpoint(path: "character")
    return try await NetworkService.shared.request(endpoint: endpoint)
  }
}
