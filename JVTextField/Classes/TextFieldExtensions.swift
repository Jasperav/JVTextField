import JVView
import JVChangeableValue

public extension UITextField {
    func set(fontType: ContentTypeTextFont, placeholderText: String, placeHolderTextFontType: ContentTypeTextFont) {
        self.placeholder = placeholderText
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.font : placeHolderTextFontType.font,
                                                                                              .foregroundColor: placeHolderTextFontType.color])
        
        self.font = fontType.font
        self.textColor = fontType.color
    }
}

public protocol JVTextFieldHolder {
    var textField: JVTextField { get }
}

public extension Changeable where Self: JVTextFieldHolder {
    func determineHasBeenChanged() -> Bool {
        return textField.determineHasBeenChanged()
    }
    
    func reset() {
        textField.text = textField.oldValue!()
    }
}
