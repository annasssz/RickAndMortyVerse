//
//  CharacterRepositoring.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import Foundation

protocol CharacterRepositoring {
  func getCharacters(page: Int?) async throws -> CharacterResponse
  func getCharacter(id: Int) async throws -> CharacterItem
}
