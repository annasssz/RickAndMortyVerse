//
//  ViewController.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/28/24.
//

import UIKit

class CharacterListViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .red
    
    Task(priority: .userInitiated) { [weak self] in
      guard let self else {
        return
      }
      
      do {
        try await Task.sleep(nanoseconds: 2_000_000_000)

        let repo = CharacterRepository()
        let data = try await repo.getCharacters()
        print(data)
      } catch {
        dump(error)
      }
    }
  }
}
