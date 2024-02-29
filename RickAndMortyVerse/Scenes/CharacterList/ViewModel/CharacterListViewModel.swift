//
//  CharacterListViewModel.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import Foundation

public enum DataState {
  case idle
  case loading
  case loaded
  case error
  case finished
}

protocol CharacterListViewModelType {
  func viewDidLoad()
  
  var data: [CharacterItem] { get }
}

class CharacterListViewModel: CharacterListViewModelType {
  var dataState: DataState = .idle
  var data: [CharacterItem] = []
  var page: Int = 0
  
  init() { }
  
  func viewDidLoad() {
    Task { [weak self] in
      guard let self else {
        return
      }
      
      await self.fetchCharacters()
    }
  }
  
  private func fetchCharacters() async {
    do {
      let repository = CharacterRepository()
      
      let response = try await repository.getCharacters(page: page)
      map(data: response.results)
    } catch {
      dataState = .error
      print(error)
    }
  }
  
  private func map(data: [CharacterItem]) {
    dataState = data.count == 0 ? .finished : .loaded
    self.data.append(contentsOf: data)
  }
}
