//
//  Observable.swift
//  RickAndMortyVerse
//
//  Created by Ana Mepisashvili on 2/29/24.
//

import Foundation

class Observable<T> {
  private typealias ListenerType = ((T) -> Void)

  var value: T {
    didSet {
      switch (onNext, listener) {
      case (.some(let onNext), .some(let listener)):
        queue.async { [weak self] in
          guard let self = self else {
            return
          }

          onNext(self.value)
          listener(self.value)
        }
      case (.some(let onNext), .none):
        queue.async { [weak self] in
          guard let self = self else {
            return
          }

          onNext(self.value)
        }
      case (.none, .some(let listener)):
        queue.async { [weak self] in
          guard let self = self else {
            return
          }

          listener(self.value)
        }
      default:
        break
      }
    }
  }

  private var listener: ListenerType?
  private var queue: DispatchQueue = .main
  private var onNext: ((T) -> Void)?
  private var comparer: ((T, T) -> Bool)?

  init(_ value: T) {
    self.value = value
  }

  func bind(_ closure: @escaping (T) -> Void, latest: Bool = true) {
    if latest {
      queue.async { [weak self] in
        guard let self = self else {
          return
        }

        closure(self.value)
      }
    }

    listener = closure
  }

  func onNext(_ value: T) {
    guard let comparer = comparer else {
      self.value = value
      return
    }

    guard comparer(self.value, value) == false else {
      return
    }

    self.value = value
  }

}

extension Observable {
  static func just(_ value: T) -> Observable {
    Observable(value)
  }
}
