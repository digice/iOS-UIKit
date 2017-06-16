//
//  Keyboard.swift
//  iOS-UIKit
//
//  Created by Roderic Linguri <linguri@digices.com>
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

protocol KeyboardDelegate {
  func keyboardWillShow(_ frame: CGRect)
  func keyboardWillChange(_ frame: CGRect)
  func keyboardDidHide()
}

class Keyboard {
  
  static let shared: Keyboard = Keyboard()
  
  var delegate: KeyboardDelegate?
  
  private init() {
    NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.kbWillChange), name: .UIKeyboardWillChangeFrame, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.kbDidHide), name: .UIKeyboardDidHide, object: nil)
  }
  
  @objc private func kbWillShow(_ notification: Notification) -> Void {
    if let userInfo = notification.userInfo {
      if let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
        if let delegate = self.delegate {
          delegate.keyboardWillShow(frame)
        }
      }
    }
  }
  
  @objc private func kbWillChange(_ notification: Notification) {
    if let userInfo = notification.userInfo {
      if let frame = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
        if let delegate = self.delegate {
          delegate.keyboardWillChange(frame)
        }
      }
    }
  }
  
  @objc private func kbDidHide(_ notification: Notification) {
    if let delegate = self.delegate {
      delegate.keyboardDidHide()
    }
  }
  
}
