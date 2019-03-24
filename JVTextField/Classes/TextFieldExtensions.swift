import JVView
import JVChangeableValue

public extension UITextField {
    func set(fontType: ContentTypeTextFont, placeholderText: String, placeHolderTextFontType: ContentTypeTextFont) {
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.font : placeHolderTextFontType.font,
                                                                                              .foregroundColor: placeHolderTextFontType.color])
        
        self.font = fontType.font
        self.textColor = fontType.color
        
        guard self.placeholder == nil || self.placeholder == "" else {
            // The user defined a custom placeholder text, don't overwrite it.
            return
        }
        
        self.placeholder = placeholderText
    }
    
    var string: String {
        return text!
    }
}

public protocol JVTextFieldHolder {
    var textField: JVTextField { get }
}

public extension Changeable where Self: JVTextFieldHolder {
    var isChanged: Bool {
        return textField.isChanged
    }

    func reset() {
        textField.text = textField.oldValue
    }
}
