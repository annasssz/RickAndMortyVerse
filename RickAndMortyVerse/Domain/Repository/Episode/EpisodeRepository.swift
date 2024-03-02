//
//  EpisodeRepository.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import Foundation

class EpisodeRepository: EpisodeRepositoring {
  let service: NetworkServiceType
  
  init(service: NetworkServiceType = NetworkService.shared) {
    self.service = service
  }
  
  func getEpisodes(ids: [Int]?) async throws -> [EpisodeResponse]? {
    let idString = ids?.map(String.init).joined(separator: ",") ?? ""

    let endpoint = Endpoint(path: makeEndpoint(for: idString))
    return try await service.request(endpoint: endpoint)
  }

  func getEpisode(id: String) async throws -> EpisodeResponse? {
    guard let lastPathComponent = URL(string: id)?.lastPathComponent else {
      throw NetworkError.invalidURL
    }

    let endpoint = Endpoint(path: makeEndpoint(for: lastPathComponent))
    return try await service.request(endpoint: endpoint)
  }

  private func makeEndpoint(for ids: String) -> String {
    return "episode/\(ids)"
  }
}
