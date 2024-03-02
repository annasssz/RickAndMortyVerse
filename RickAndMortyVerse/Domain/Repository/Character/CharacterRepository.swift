//
//  CharacterRepository.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

class CharacterRepository: CharacterRepositoring {
  let service: NetworkServiceType
  
  init(service: NetworkServiceType = NetworkService.shared) {
    self.service = service
  }
  
  func getCharacters(page: Int? = nil) async throws -> CharacterResponse {
    let endpoint = Endpoint(path: "character", queryItems: page.map { [URLQueryItem(name: "page", value: String($0))] })
    return try await service.request(endpoint: endpoint)
  }
  
  func getCharacter(id: Int) async throws -> CharacterItem {
    guard let lastPathComponent = URL(string: "\(id)")?.lastPathComponent else {
      throw NetworkError.invalidURL
    }

    let endpoint = Endpoint(path: makeEndpoint(for: lastPathComponent))
    return try await service.request(endpoint: endpoint)
  }
  
  private func makeEndpoint(for id: String) -> String {
    return "character/\(id)"
  }
}
