# Checkbox #

_A very simple checkbox (UIButton subclass) which draws itself. No image assets required_

1. Import the Checkbox.swift class file into your project

2. The following runtime attributes can be edited in Interface Builder:

- checked (true or false)
- stroke (the line weight in points)
- tint (the color of the lines)

additionally, there is a public method to toggle the state of the checkbox:

- toggle() (check the box if unchecked, or uncheck if checked)

2. Refer to the included ViewController.swift file to see an example of the implementation

- add the CheckboxDelegate protocol to your class declaration
```swift
class ViewController: UIViewController, CheckboxDelegate
```

- in awakeFromNib() or viewDidLoad, set yourself as the delegate
```swift
self.myCheckbox.delegate = self
```

- optionally implement the two available delegate methods
```swift
func checkboxWasChecked()
func checkboxWasUnchecked()
```