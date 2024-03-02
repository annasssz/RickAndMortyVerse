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
  
  func getEpisodes(ids: [Int]?) async throws -> [EpisodeResponse] {
    let idString = ids?.map(String.init).joined(separator: ",") ?? ""
    let endpoint = makeEndpoint(for: idString)
    
    return try await service.request(endpoint: endpoint)
  }
  
  private func makeEndpoint(for ids: String) -> Endpoint {
    return Endpoint(path: "episode/\(ids)")
  }
}
