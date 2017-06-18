//
//  KeyboardController.swift
//  RespondingToKeyboardEvents
//
//  Created by Roderic Linguri
//  Copyright © 2017 Digices LLC. All rights reserved.
//

/***
  Extend KeyboardController to be notified of keyboard events in subclass
 ***/

import UIKit

enum KeyboardEvent {
  case hide
  case show
  case change
}

class KeyboardController: UIViewController {
  
  // MARK: - KeyboardController Properties

  // storage for the last keyboard event
  var keyboardEvent: KeyboardEvent = .hide
  
  // saved height of keyboard
  var keyboardHeight: CGFloat = 0

  // MARK: - KeyboardController Methods

  // override to handle keyboard appearring
  func keyboardDidShow() {
    
  }
  
  // override to handle keyboard changes
  func keyboardDidChange() {
    
  }
  
  // override to handle hiding events
  func keyboardDidHide() {
    
  }
  
  func dismissKeyboard() {
    self.view.endEditing(true)
    self.keyboardEvent = .hide
    self.keyboardHeight = 0
    print("event:  \(self.keyboardEvent)")
    print("height: \(self.keyboardHeight)")
    self.keyboardDidHide()
  }
  
  // filter system notification
  @objc func handleNotification(_ notification: Notification) {

    print("-------- Keyboard Event Notification --------")
    
    // use optional chaining to unwrap keyboard frame
    if let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
      
      // need to convert to this view's coordinate space
      let convertedFrame = self.view.convert(frame, from: UIScreen.main.coordinateSpace)
      
      // calculate keyboard height on screen
      let newKeyboardHeight = self.view.bounds.height - convertedFrame.minY
      
      // make sure the height isn't zero
      if newKeyboardHeight != 0 {
        
        if self.keyboardEvent == .hide {
          self.keyboardHeight = newKeyboardHeight
          self.keyboardEvent = .show
          print("event:  \(self.keyboardEvent)")
          print("height: \(self.keyboardHeight)")
          self.keyboardDidShow()
        } // ./previous event was hide
        
        else {
          
          if newKeyboardHeight != self.keyboardHeight {
            self.keyboardHeight = newKeyboardHeight
            self.keyboardEvent = .change
            print("event:  \(self.keyboardEvent)")
            print("height: \(self.keyboardHeight)")
            self.keyboardDidChange()
          } // ./new height is different that last height
          
          else {
            print("error:  notification height was the same as previous height")
          } // ./new height is the same as last height
          
        } // ./previous event was not hide
        
      } // ./keyboard height was not zero
      
      else {
        print("error:  the keyboard height in notification was zero")
      } // ./new height was zero
      
    } // ./keyboard frame extracted
    
    else {
      print("error:  frame could not be extracted from notification")
    } // ./keyboard frame not extracted
    
  }

  // MARK: - UIViewController Methods
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotification), name: .UIKeyboardWillChangeFrame, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
