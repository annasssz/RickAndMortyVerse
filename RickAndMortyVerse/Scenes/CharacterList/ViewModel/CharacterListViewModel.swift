//
//  CharacterListViewModel.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import Foundation

protocol BaseLoadMoreViewModel {
  var page: Int { get set }
  
  func refreshData() async
  func loadMore() async
}

public enum LoadMoreDataState {
  case idle
  case loading
  case loaded
  case error
  case finished
}

class BaseLoadMoreListViewModel<T>: BaseLoadMoreViewModel {
  var data: [T] = []
  var page: Int = -1
  var dataState: LoadMoreDataState = .idle
  
  func refreshData() async{
    fatalError()
  }
  
  func loadMore() async {
    fatalError()
  }
  
  func eraseData() {
    page = -1
    data = []
  }
}

protocol CharacterListViewModel {
  func refresh() 
  func loadMode()
}

class CharacterListViewModelImpl: BaseLoadMoreListViewModel<CharacterItem> {
  private var characterFetcher: CharacterFetching
  
  init(characterFetcher: CharacterFetching) {
    self.characterFetcher = characterFetcher
  }

  func viewDidLoad() {
    Task { [weak self] in
      guard let self else {
        return
      }

      await self.fetchCheracters()
    }
  }
  
  func map(data: [CharacterItem]) {
    dataState = data.count == 0 ? .finished : .loaded
    self.data.append(contentsOf: data)
  }
  
  private func fetchCheracters() async {
    do {
      let data = try await characterFetcher.fetchCharacters(page: self.page)
      map(data: data)
    } catch {
      dataState = .error
    }
  }
  
  override func refreshData() async {
    eraseData()
    await loadMore()
  }
  
  override func loadMore() async {
    dataState = .loading
    await fetchCheracters()
  }
}

protocol CharacterFetching {
  func fetchCharacters(page: Int) async throws -> [CharacterItem]
}

class FetchCharactersUseCase: CharacterFetching {
  private let charactersRepository = CharacterRepository()

  func fetchCharacters(page: Int) async throws -> [CharacterItem] {
    do {
      let response = try await charactersRepository.getCharacters(page: page)
      return response.results
    } catch {
      throw error
    }
  }
}
