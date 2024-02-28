//
//  NetworkService.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

class NetworkService: NetworkServiceType {
  private let urlSession: URLSession = .shared
  private let urlBuilder: APIURLBuilder = APIURLBuilder()

  static let shared = NetworkService()

  private init() {}

  func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
    guard let url = urlBuilder.buildURL(from: endpoint) else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.headers
    request.httpBody = endpoint.body
    
    do {
      let (data, response) = try await urlSession.data(for: request)
      
      guard let response = response as? HTTPURLResponse,
        (200..<300).contains(response.statusCode) else {
        throw NetworkError.requestFailed(response as? Error ?? URLError(.badServerResponse))
      }
      
      let decodedData = try JSONDecoder().decode(T.self, from: data)
      return decodedData
    } catch {
      throw NetworkError.requestFailed(error)
    }
  }
}
