//
//  CharacterDetailInfoViewModel.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import Foundation

protocol CharacterDetailInfoViewModelType {
  var characterItem: CharacterItem { get }
}

class CharacterDetailInfoViewModel: CharacterDetailInfoViewModelType {
  let characterItem: CharacterItem
  
  init(characterItem: CharacterItem) {
    self.characterItem = characterItem
  }
}
