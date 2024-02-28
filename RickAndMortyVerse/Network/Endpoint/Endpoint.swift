//
//  Endpoint.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import Foundation

struct Endpoint {
  let path: String
  let method: HTTPMethod
  let queryItems: [URLQueryItem]?
  let headers: [String: String]?
  let body: Data?
  
  init(
    path: String,
    method: HTTPMethod,
    queryItems: [URLQueryItem]? = nil,
    headers: [String : String]? = nil, 
    body: Data? = nil
  ) {
    self.path = path
    self.method = method
    self.queryItems = queryItems
    self.headers = headers
    self.body = body
  }
}
