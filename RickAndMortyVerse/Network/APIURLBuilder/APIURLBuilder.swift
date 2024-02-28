//
//  APIURLBuilder.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

class APIURLBuilder {
  private let baseURL: String = "rickandmortyapi.com"
  private let suffix: String = "/api"
  private let scheme: String = "https"

  func buildURL(from endpoint: Endpoint) -> URL? {
    var components = URLComponents()
    components.scheme = scheme
    components.host = baseURL
    components.path = suffix + endpoint.path
    components.queryItems = endpoint.queryItems
    return components.url
  }
}
