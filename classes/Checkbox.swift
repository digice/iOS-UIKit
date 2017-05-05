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
  var stroke: CGFloat = 0.5

  @IBInspectable
  var tint: UIColor = .black

  override func awakeFromNib() {
    self.addTarget(self, action: #selector(self.toggle), for: .touchUpInside)
    self.contentMode = .redraw
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
    let offset = self.stroke / 2
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0 + offset))
    path.addLine(to: CGPoint(x: self.bounds.width - offset, y: 0 + offset))
    path.addLine(to: CGPoint(x: self.bounds.width - offset, y: self.bounds.height - offset))
    path.addLine(to: CGPoint(x: 0 + offset, y: self.bounds.height - offset))
    path.addLine(to: CGPoint(x: 0 + offset, y: 0))
    path.lineWidth = self.stroke
    return path
  }

  func check() -> UIBezierPath {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0 + self.stroke, y: 0 + self.stroke))
    path.addLine(to: CGPoint(x: self.bounds.width - self.stroke, y: self.bounds.height - self.stroke))
    path.move(to: CGPoint(x: self.bounds.width - self.stroke, y: 0 + self.stroke))
    path.addLine(to: CGPoint(x: 0 + self.stroke, y: self.bounds.height - self.stroke))
    path.lineWidth = self.stroke
    return path
  }

  override func draw(_ rect: CGRect) {
    tint.set()
    box().stroke()
    if self.checked == true {
      check().stroke()
    }
  }

}
