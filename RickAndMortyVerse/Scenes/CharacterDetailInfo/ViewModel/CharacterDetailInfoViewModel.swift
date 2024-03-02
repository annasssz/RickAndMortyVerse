//
//  CharacterDetailInfoViewModel.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import Foundation

protocol CharacterDetailInfoViewModelType {
  var dataState: Observable<DataState> { get }
  
  var characterItem: CharacterItem { get }
  var episodes: [Episode] { get }
  
  func viewDidLoad()
}

class CharacterDetailInfoViewModel: CharacterDetailInfoViewModelType {
  var dataState: Observable<DataState> = .just(.idle)
  
  let characterItem: CharacterItem
  var episodes: [Episode] = []
  
  init(characterItem: CharacterItem) {
    self.characterItem = characterItem
  }
  
  func viewDidLoad() {
    Task { [weak self] in
      guard let self else { return }
      
      await self.fetchEpisodes()
    }
  }
  
  private func fetchEpisodes() async {
    dataState.onNext(.loading)
    do {
      let repository = EpisodeRepository()
      let response = try await repository.getEpisodes(ids: characterItem.episode.getIds())
      map(data: response)
    } catch {
      dataState.onNext(.error)
    }
  }
  
  private func map(data: [EpisodeResponse]) {
    episodes = data.map({ .init(title: $0.name, characters: $0.characters?.getIds() ?? []) })
    dataState.onNext(.loaded)
  }
}
