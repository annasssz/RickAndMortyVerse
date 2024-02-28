//
//  NetworkServiceType.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

protocol NetworkServiceType {
  func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}
