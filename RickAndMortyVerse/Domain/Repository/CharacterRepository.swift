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
    let endpoint = Endpoint(path: "/character", method: .get)
    return try await NetworkService.shared.request(endpoint: endpoint)
  }
}
