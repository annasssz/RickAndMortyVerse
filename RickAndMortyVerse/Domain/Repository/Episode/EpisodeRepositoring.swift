//
//  EpisodeRepositoring.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import Foundation

protocol EpisodeRepositoring {
  func getEpisodes(ids: [Int]?) async throws -> [EpisodeResponse]?
  func getEpisode(id: String) async throws -> EpisodeResponse?
}
