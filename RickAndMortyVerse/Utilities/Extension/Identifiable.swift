//
//  Identifiable.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 3/2/24.
//

import UIKit

extension Identifiable where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
