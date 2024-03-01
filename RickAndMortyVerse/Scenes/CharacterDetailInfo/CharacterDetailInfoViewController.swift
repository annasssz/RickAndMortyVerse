//
//  CharacterDetailInfoViewController.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/1/24.
//

import UIKit
class CharacterDetailInfoViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    largeTitleDisplayMode()
  }
  
  func largeTitleDisplayMode() {
    self.navigationItem.largeTitleDisplayMode = .never
  }
}
