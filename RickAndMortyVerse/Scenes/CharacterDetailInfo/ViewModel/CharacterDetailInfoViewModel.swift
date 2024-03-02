//
//  CharacterDetailInfoViewModel.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import Foundation

protocol CharacterDetailInfoViewModelType {
  var dataState: Observable<DataState> { get }
  
  var characterItem: CharacterItem? { get }
  var id: Int { get }
  var episodes: [Episode] { get }
  
  func viewDidLoad()
}

class CharacterDetailInfoViewModel: CharacterDetailInfoViewModelType {
  var dataState: Observable<DataState> = .just(.idle)
  
  let id: Int
  var characterItem: CharacterItem?
  var episodes: [Episode] = []
  
  init(id: Int) {
    self.id = id
  }
  
  func viewDidLoad() {
    Task { [weak self] in
      guard let self else { return }
      
      await self.fetchCharacter()
    }
  }
  
  private func fetchCharacter() async {
    dataState.onNext(.loading)
    do {
      let repository = CharacterRepository()
      
      characterItem = try await repository.getCharacter(id: id)
      await fetchEpisodes()
    } catch {
      dataState.onNext(.error)
    }
  }
  
  private func fetchEpisodes() async {
    dataState.onNext(.loading)
    do {
      let repository = EpisodeRepository()
      
      guard let characterItem else {
        dataState.onNext(.error)
        return
      }
      
      if characterItem.episode.count == 1, let episode = characterItem.episode.first {
        let response = try await repository.getEpisode(id: episode)
        
        if let response {
          map(data: [response])
        }
      } else {
        let response = try await repository.getEpisodes(ids: characterItem.episode.getIds())
        map(data: response ?? [])
      }
    } catch {
      dataState.onNext(.error)
    }
  }
  
  private func map(data: [EpisodeResponse]) {
    episodes = data.map({ .init(title: $0.name, characters: $0.characters?.getIds() ?? []) })
    dataState.onNext(.loaded)
  }
}
