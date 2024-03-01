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
  func filterData(with searchText: String)
  
  var dataState: Observable<DataState> { get }
  var filteredData: [CharacterItem] { get }
}

class CharacterListViewModel: CharacterListViewModelType {
  var dataState: Observable<DataState> = .just(.idle)
  var data: [CharacterItem] = []
  var filteredData: [CharacterItem] = []
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
  
  func filterData(with searchText: String) {
    if searchText.isEmpty {
      self.filteredData = data
      dataState.onNext(.loaded)
      return
    }
    
    let filteredData = data.filter { character in
      print(
        "ssss", character.name.lowercased(),
        "and", searchText.lowercased(),
        "result",  character.name.lowercased().contains(searchText.lowercased())
      )
      return character.name.lowercased().contains(searchText.lowercased())
    }
    
    print("data", filteredData.map(\.name))
    self.filteredData = filteredData
    dataState.onNext(.loaded)
  }
  
  private func map(data: [CharacterItem]) {
    self.data.append(contentsOf: data)
    self.filteredData = self.data
    dataState.onNext(data.count == 0 ? .finished : .loaded)
  }
}
