//
//  ViewController.swift
//  iOS-UIKit
//  Checkbox Implementation Example
//  Created by Roderic Linguri on 5/5/17.
//  Copyright © 2017 Digices LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CheckboxDelegate {

  // MARK: - IBOUtlets

  @IBOutlet weak var myCheckbox: Checkbox!

  // MARK: - UIViewController

  override func viewDidLoad() {
    super.viewDidLoad()
    self.myCheckbox.delegate = self
  }

  // MARK: - CheckboxDelegate

  func checkboxWasChecked() {
    print("checked!")
  }

  func checkboxWasUnchecked() {
    print("unchecked!")
  }

}
