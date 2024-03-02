//
//  NetworkError.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

enum NetworkError: Error {
  case invalidURL
  case requestFailed(Error)
  case decodingError(Error)
  case other(String)
}

