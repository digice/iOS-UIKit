//
//  EntryFormCombo.swift
//  iOS UIKit
//  Custom Reusable Form Combo
//  Created by Roderic Linguri on 5/4/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

@IBDesignable
class EntryFormCombo: UIView, UITextFieldDelegate, CheckboxDelegate {
  
  // MARK: - UI Customization Options
  
  @IBInspectable
  var tint: UIColor = .darkGray
  
  @IBInspectable
  var stroke: CGFloat = 0.5
  
  @IBInspectable
  var separatorColor: UIColor = .darkGray
  
  @IBInspectable
  public var labelText: String?
  
  @IBInspectable
  public var labelFontSize: CGFloat = 12
  
  @IBInspectable
  public var fieldValue: String?
  
  @IBInspectable
  public var fieldPlaceholder: String?
  
  @IBInspectable
  public var fieldHeight: CGFloat = 38
  
  @IBInspectable
  public var fieldFontSize: CGFloat = 18
  
  @IBInspectable
  public var widthThreshold: CGFloat = 391
  
  public var boxAChecked: Bool?
  
  public var boxBChecked: Bool?
  
  public var boxCChecked: Bool?
  
  // MARK: - Private UI Elements
  
  private var label: UILabel!
  
  var textField: UITextField!
  
  private var checkboxA: Checkbox!
  
  private var checkboxB: Checkbox!
  
  private var checkboxC: Checkbox!
  
  // MARK: - UIView
  override func awakeFromNib() {
    super.awakeFromNib()
    self.backgroundColor = UIColor.clear
    self.contentMode = .redraw
  }
  
  // MARK: - Public Methods
  
  // call to change the state of checkbox A
  public func toggleA() {
    if self.boxAChecked == true {
      self.boxAChecked = false
    } else {
      self.boxAChecked = true
    }
    self.checkboxA.toggle()
  }
  
  // call to change the state of checkbox B
  public func toggleB() {
    if self.boxBChecked == true {
      self.boxBChecked = false
    } else {
      self.boxBChecked = true
    }
    self.checkboxB.toggle()
  }
  
  // call to change the state of checkbox B
  public func toggleC() {
    if self.boxCChecked == true {
      self.boxCChecked = false
    } else {
      self.boxCChecked = true
    }
    self.checkboxC.toggle()
  }
  
  // draws a separator line at the bottom of the combo
  private func border() -> UIBezierPath {
    let path = UIBezierPath()
    let lineY = self.bounds.height - (self.stroke / 2)
    path.move(to: CGPoint(x: 0, y: lineY))
    path.addLine(to: CGPoint(x: self.bounds.width, y: lineY))
    path.lineWidth = self.stroke
    return path
  }
  
  // creates the fieldLabel
  private func setLabel() {
    
    if self.bounds.width > 391 {
      self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width * CGFloat(0.22), height: fieldHeight))
      self.label.textAlignment = .right
    } else {
      self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width * CGFloat(0.5), height: 18))
      self.label.textAlignment = .left
    }
    
    if let ltx = self.labelText {
      self.label.text = ltx
    } else {
      self.label.text = "Label"
    }
    
    self.label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .subheadline), size: self.labelFontSize)
    self.label.textColor = self.tint
    
    self.addSubview(self.label)
    
  }
  // create checkbox 0 (A)
  private func setCheckboxA() {
    
    // x position is consistent regardless of orientation
    let xPos = self.bounds.width - 90
    
    if self.bounds.width > 391 {
      self.checkboxA = Checkbox(frame: CGRect(x: xPos, y: self.bounds.midY - 9, width: 18, height: 18))
      self.checkboxA.center = CGPoint(x: xPos + 9, y: self.bounds.midY)
    } else {
      self.checkboxA = Checkbox(frame: CGRect(x: xPos, y: 0, width: 18, height: 18))
      self.checkboxA.center = CGPoint(x: xPos + 9, y: 9)
    }
    
    checkboxA.tag = 0
    checkboxA.delegate = self
    checkboxA.tint = self.tint
    checkboxA.stroke = self.stroke
    checkboxA.addTarget(self, action: #selector(self.toggleA), for: .touchUpInside)
    
    if self.boxAChecked == true {
      self.checkboxA.checked = true
    }
    
    self.addSubview(checkboxA)
    
  }
  
  // create checkbox 1 (B)
  private func setCheckboxB() {
    
    // x position is consistent regardless of orientation
    let xPos = self.bounds.width - 54
    
    if self.bounds.width > self.widthThreshold {
      self.checkboxB = Checkbox(frame: CGRect(x: xPos, y: self.bounds.midY - 9, width: 18, height: 18))
      self.checkboxB.center = CGPoint(x: xPos + 9, y: self.bounds.midY)
    } else {
      self.checkboxB = Checkbox(frame: CGRect(x: xPos, y: 0, width: 18, height: 18))
      self.checkboxB.center = CGPoint(x: xPos + 9, y: 9)
    }
    
    checkboxB.tag = 1
    checkboxB.delegate = self
    checkboxB.tint = self.tint
    checkboxB.stroke = self.stroke
    checkboxB.addTarget(self, action: #selector(self.toggleB), for: .touchUpInside)
    
    if self.boxBChecked == true {
      self.checkboxB.checked = true
    }
    
    self.addSubview(checkboxB)
    
  }
  
  // create checkbox 2 (C)
  private func setCheckboxC() {
    
    // x position is consistent regardless of orientation
    let xPos = self.bounds.width - 18
    
    if self.bounds.width > self.widthThreshold {
      self.checkboxC = Checkbox(frame: CGRect(x: xPos, y: self.bounds.midY - 9, width: 18, height: 18))
      self.checkboxC.center = CGPoint(x: xPos + 9, y: self.bounds.midY)
    } else {
      self.checkboxC = Checkbox(frame: CGRect(x: xPos, y: 0, width: 18, height: 18))
      self.checkboxC.center = CGPoint(x: xPos + 9, y: 9)
    }
    
    checkboxC.tag = 2
    checkboxC.delegate = self
    checkboxC.tint = self.tint
    checkboxC.stroke = self.stroke
    checkboxC.addTarget(self, action: #selector(self.toggleC), for: .touchUpInside)
    
    if self.boxCChecked == true {
      self.checkboxC.checked = true
    }
    
    self.addSubview(checkboxC)
    
  }
  
  // creates the fieldTextField
  private func setTextField() {
    
    if self.bounds.width > 391 {
      self.textField = UITextField(frame: CGRect(x: self.bounds.width * CGFloat(0.25), y: 0, width: self.bounds.width * CGFloat(0.5), height: fieldHeight))
      self.textField.textAlignment = .left
    } else {
      self.textField = UITextField(frame: CGRect(x: 0, y: self.bounds.height - (fieldHeight + self.stroke), width: self.bounds.width, height: fieldHeight))
      self.textField.textAlignment = .center
    }
    
    if let tft = self.fieldValue {
      self.textField.text = tft
    }
    
    if let tfp = self.fieldPlaceholder {
      self.textField.placeholder = tfp
    }
    
    self.textField.spellCheckingType = .no
    self.textField.autocorrectionType = .no
    self.textField.keyboardType = .emailAddress
    self.textField.keyboardAppearance = .dark
    self.textField.returnKeyType = .done
    self.textField.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: self.fieldFontSize)
    self.textField.delegate = self
    self.textField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    
    self.addSubview(self.textField)
    
  }
  
  // redraws all the elements
  override func draw(_ rect: CGRect) {
    
    for view in self.subviews {
      view.removeFromSuperview()
    }
    
    self.setLabel()
    self.setCheckboxA()
    self.setCheckboxB()
    self.setCheckboxC()
    self.setTextField()
    self.separatorColor.set()
    self.border().stroke()
    
    setNeedsDisplay()
    
  }
  
  // MARK: - UITextFieldDelegate
  // implemented to save text field value during re-draw
  
  func textFieldDidChange() {
    self.fieldValue = self.textField.text
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.fieldValue = self.textField.text
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return false
  }
  
  // MARK: - CheckboxDelegate
  
  func checkboxDidChangeState(_ tag: Int, _ checked: Bool) {
    switch tag {
    case 0:
      if checked == true {
        print("\(self.labelText!) A was checked")
      } else {
        print("\(self.labelText!) A was unchecked")
      }
    case 1:
      if checked == true {
        print("\(self.labelText!) B was checked")
      } else {
        print("\(self.labelText!) B was unchecked")
      }
    case 2:
      if checked == true {
        print("\(self.labelText!) C was checked")
      } else {
        print("\(self.labelText!) C was unchecked")
      }
    default:
      break
    }
  }
  
}
