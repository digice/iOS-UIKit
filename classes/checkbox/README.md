# Checkbox #

_A very simple checkbox (UIButton subclass) which draws itself. No image assets required_

1. Import the Checkbox.swift class file into your project

2. The following runtime attributes can be edited in Interface Builder (or set in code):

- checked (true or false)
- stroke (the line weight in points)
- tint (the color of the lines)

3. Additionally, there is a public method to toggle the state of the checkbox:

- toggle() (check the box if unchecked, or uncheck if checked)

4. Refer to the included ViewController.swift file to see an example of the implementation

- add the CheckboxDelegate protocol to your class declaration
```swift
class ViewController: UIViewController, CheckboxDelegate
```

- in awakeFromNib() or viewDidLoad(), set yourself as the delegate and assign a tag, i.e., if you have more than one checkbox
```swift
self.myCheckbox.delegate = self
self.myCheckbox.tag = 0
```

- optionally implement the available delegate method. The tag parameter identifies the checkbox and the checked parameter tells you whether checked was changed to true or false
```swift
checkboxDidChangeState(_ tag: Int, _ checked: Bool)
```
