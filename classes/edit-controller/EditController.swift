//
//  EditController.swift
//  iOS-UIKit
//
//  Created by Roderic Linguri <linguri@digices.com>
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class EditController: UIViewController, UITextFieldDelegate, KeyboardDelegate {
  
  // MARK: - Private Properties
  
  private let keyboard: Keyboard = Keyboard.shared
  
  // MARK: - Public Properties
  
  @IBInspectable
  var margin: CGFloat = 36
  
  var keyboardIsHidden: Bool = true
  
  var keyboardFrame: CGRect?
  
  var textFrame: CGRect?
  
  var contentOffset: CGPoint = CGPoint(x: 0, y: 0)
  
  var tempOffset: CGPoint = CGPoint(x: 0, y: 0)
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBOutlet weak var contentView: UIView!
  
  @IBOutlet weak var formView: UIView!
  
  // MARK: - UIViewController
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.keyboard.delegate = self
    for view in self.formView.subviews {
      if let textField = view as? UITextField {
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.editingDidBegin), for: .editingDidBegin)
      }
    }
    self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  // MARK: - EditController (self)
  
  func editingDidBegin(_ textField: UITextField) {
    self.textFrame = self.formView.convert(textField.frame, to: self.view)
    self.contentOffset = self.scrollView.contentOffset
  }
  
  func editingDidEnd(_ textField: UITextField) {
    self.textFrame = nil
  }
  
  func dismissKeyboard() {
    if !self.keyboardIsHidden {
      self.keyboardIsHidden = true
      self.scrollView.setContentOffset(self.contentOffset, animated: true)
      self.contentOffset = self.scrollView.contentOffset
      self.tempOffset = CGPoint(x: 0, y: 0)
      self.keyboardFrame = nil
      self.view.endEditing(true)
    }
  }
  
  // MARK: - KeyboardDelegate
  
  func keyboardWillShow(_ frame: CGRect) {
    self.keyboardIsHidden = false
  }
  
  func keyboardWillChange(_ frame: CGRect) {
    self.keyboardFrame = view.convert(frame, from: UIScreen.main.coordinateSpace)
    if let textFrame = self.textFrame {
      let tfBottom = textFrame.maxY
      let kbTop = self.keyboardFrame!.minY - self.margin
      let overlap = tfBottom - kbTop
      if overlap > 0 {
        self.tempOffset = CGPoint(x: self.scrollView.contentOffset.x, y: self.contentOffset.y + overlap)
        self.scrollView.setContentOffset(self.tempOffset, animated: true)
      }
    }
  }
  
  func keyboardDidHide() {
    //
  }
  
  // MARK: - UITextFieldDelegate
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.dismissKeyboard()
    return false
  }
  
}
