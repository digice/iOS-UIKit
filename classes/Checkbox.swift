//
//  Checkbox.swift
//  iOS-UIKit
//  Custom Checkbox Button
//  Created by Roderic Linguri on 5/3/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

@IBDesignable
class Checkbox: UIButton {

  @IBInspectable
  var checked: Bool = false

  @IBInspectable
  var boxStroke: CGFloat = 0.5

  @IBInspectable
  var strokeColor: UIColor = .black

  override func awakeFromNib() {
    self.addTarget(self, action: #selector(self.toggle), for: .touchUpInside)
  }

  func toggle() {
    if self.checked == true {
      self.checked = false
    } else {
      self.checked = true
    }
    setNeedsDisplay()
  }

  func box() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0 + self.boxStroke, y: 0 + self.boxStroke))
    path.addLine(to: CGPoint(x: self.bounds.width - self.boxStroke, y: 0 + self.boxStroke))
    path.addLine(to: CGPoint(x: self.bounds.width - self.boxStroke, y: self.bounds.height - self.boxStroke))
    path.addLine(to: CGPoint(x: 0 + self.boxStroke, y: self.bounds.height - self.boxStroke))
    path.addLine(to: CGPoint(x: 0 + self.boxStroke, y: 0 + (self.boxStroke / 2)))
    return path
  }

  func check() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0 + self.boxStroke, y: 0 + self.boxStroke))
    path.addLine(to: CGPoint(x: self.bounds.width - self.boxStroke, y: self.bounds.height - self.boxStroke))
    path.move(to: CGPoint(x: self.bounds.width - self.boxStroke, y: 0 + self.boxStroke))
    path.addLine(to: CGPoint(x: 0 + self.boxStroke, y: self.bounds.height - self.boxStroke))
    return path
  }

  override func draw(_ rect: CGRect) {
    strokeColor.set()
    box().stroke()
    if self.checked == true {
      check().stroke()
    }
  }

}
