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
  func loadMore(index: IndexPath)
  
  var dataState: Observable<DataState> { get }
  var data: [CharacterItem] { get }
}

class CharacterListViewModel: CharacterListViewModelType {
  var dataState: Observable<DataState> = .just(.idle)
  var data: [CharacterItem] = []
  var currentPage: Int = 1
  var paginationInfo: PaginationInfo?
  
  init() { }
  
  func viewDidLoad() {
    Task { [weak self] in
      guard let self else { return }
      
      await self.fetchCharacters()
    }
  }
  
  func loadMore(index: IndexPath) {
    Task { [weak self] in
      guard let self else { return }
      guard self.dataState.value != .loading else { return }
      guard let paginationInfo = paginationInfo, currentPage < paginationInfo.pages, index.row == data.count - 1 else { return }

      self.currentPage += 1

      await fetchCharacters()
    }
  }
  
  private func fetchCharacters() async {
    dataState.onNext(.loading)
    do {
      let repository = CharacterRepository()
      let response = try await repository.getCharacters(page: currentPage)
      self.paginationInfo = response.info
      map(data: response.results)
    } catch {
      dataState.onNext(.error)
      print(error)
    }
  }
  
  private func map(data: [CharacterItem]) {
    self.data.append(contentsOf: data)
    dataState.onNext(data.count == 0 ? .finished : .loaded)
  }
}
