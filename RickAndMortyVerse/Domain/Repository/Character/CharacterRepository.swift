//
//  CharacterRepository.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

class CharacterRepository: CharacterRepositoring {
  func getCharacters(page: Int? = nil) async throws -> CharacterResponse {
    let endpoint = Endpoint(path: "character", queryItems: page.map { [URLQueryItem(name: "page", value: String($0))] })
    return try await NetworkService.shared.request(endpoint: endpoint)
  }
}
