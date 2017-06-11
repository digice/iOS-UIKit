//
//  FormGroup.swift
//  iOS-UIKit
//
//  Created by Roderic Linguri on 6/11/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//  MIT License
//

import UIKit

protocol FormGroupDelegate {
  func formGroupDidStartEditing(at yPos: CGFloat)
  func formGroupDidEndEditing()
}

@IBDesignable
class FormGroup: UIView, UITextFieldDelegate {

  // - MARK: Public Properties

  var delegate: FormGroupDelegate?

  @IBInspectable
  public var key: String = ""

  @IBInspectable
  public var value: String = ""

  @IBInspectable
  public var threshold: CGFloat = 414

  // border properties

  public var strokeWeight: CGFloat = 0.5

  @IBInspectable
  public var strokeColor: UIColor = .lightGray

  // label properties

  @IBInspectable
  public var labelTint: UIColor = UIColor(red: 15/255, green: 121/255, blue: 252/255, alpha: 1)

  @IBInspectable
  public var labelFontSize: CGFloat = 10

  // field properties

  @IBInspectable
  public var fieldTint: UIColor = .darkGray

  // - MARK: Private Properties

  private var label: UILabel!

  private var field: UITextField!

  private var landscape: Bool = false

  private var yPosition: CGFloat = 0

  // MARK: UIFormGroup (self)

  private func border() -> UIBezierPath {
    let yPosition = self.bounds.height - self.strokeWeight
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: yPosition))
    path.addLine(to: CGPoint(x: self.bounds.width, y: yPosition))
    path.lineWidth = self.strokeWeight
    return path
  }

  private func separator() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: self.bounds.width * 0.25, y: 0))
    path.addLine(to: CGPoint(x: self.bounds.width * 0.25, y: self.bounds.height))
    path.lineWidth = self.strokeWeight
    return path
  }

  private func setupLabel() {

    if (self.label != nil) {
      self.label.removeFromSuperview()
    }

    if self.landscape == true {
      self.label = UILabel(frame: CGRect(x: 0, y: 1, width: self.bounds.width * 0.22, height: 36))
      self.label.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .subheadline), size: 14)
      self.label.textAlignment = .right
    } else {
      self.label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 12))
      self.label.font = UIFont.boldSystemFont(ofSize: 10)
      self.label.textAlignment = .left
    }

    self.label.text = self.key
    self.label.textColor = self.labelTint

    self.addSubview(self.label)

  }

  private func setupField() {

    if (self.field) != nil {
      if let fieldText = self.field.text {
        if fieldText.characters.count > 0 {
          self.value = fieldText
        }
      }
      self.field.removeFromSuperview()
    }

    if self.landscape == true {
      let frame = CGRect(x: self.bounds.width * 0.28, y: 0, width: self.bounds.width * 0.74, height: 36)
      self.field = UITextField(frame: frame)
      self.field.textAlignment = .left
    } else {
      let frame = CGRect(x: 0, y: 6, width: self.bounds.width, height: 30)
      self.field = UITextField(frame: frame)
      self.field.textAlignment = .center
    }
    
    self.field.delegate = self
    self.field.placeholder = self.key
    
    if self.value.characters.count > 0 {
      self.field.text = self.value
    }
    
    self.field.textColor = self.fieldTint
    self.field.font = UIFont(descriptor: .preferredFontDescriptor(withTextStyle: .body), size: 18)
    self.field.addTarget(self, action: #selector(self.toggleLabel), for: .editingChanged)
    
    self.addSubview(self.field)

  }

  private func toggleLabel() {
    if let fieldText = self.field.text {
      if fieldText.characters.count == 0 {
        if self.landscape != true {
          self.label.isHidden = true
        }
        self.field.placeholder = self.key
      } else {
        self.label.isHidden = false
      }
    }
  }

  // MARK: UIView

  override func awakeFromNib() {
    super.awakeFromNib()
    self.contentMode = .redraw
    self.backgroundColor = .clear
  }

  override func draw(_ rect: CGRect) {

    if let container = self.superview {
      if container.bounds.width > self.threshold {
        self.landscape = true
      } else {
        self.landscape = false
      }
      self.yPosition = container.frame.minY + self.frame.minY
    }

    self.strokeColor.set()
    self.border().stroke()

    if self.landscape == true {
      self.separator().stroke()
    }

    self.setupField()
    self.setupLabel()
    self.toggleLabel()

    setNeedsDisplay()

  }
  
  // MARK: - UITextFieldDelegate

  func textFieldDidBeginEditing(_ textField: UITextField) {
    self.label.isHidden = false
    self.field.placeholder = ""
    if let delegate = self.delegate {
      delegate.formGroupDidStartEditing(at: 0)
    }
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    self.value = self.field.text!
    self.toggleLabel()
    if let delegate = self.delegate {
      delegate.formGroupDidEndEditing()
    }
  }

}
