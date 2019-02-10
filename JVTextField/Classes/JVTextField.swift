import UIKit
import JVConstraintEdges
import JVView
import JVChangeableValue

open class JVTextField: UITextField, UITextFieldDelegate, ChangeableValues {
    
    public static var defaultTextFieldInitializer: TextFieldInitializer?
    
    public var currentValue = ""
    public var oldValue: (() -> (String))?
    public var hasChanged: ((Bool) -> ())?
    public var validate: ((String) -> (Bool))?
    public var didReturn: (() -> ())?
    
    public init(textFieldInitializer: TextFieldInitializer = JVTextField.defaultTextFieldInitializer!, text: String? = nil, validate: ((String) -> (Bool))? = nil, placeholderText: String? = nil) {
        self.validate = validate
        
        super.init(frame: .zero)
        
        self.text = text
        self.placeholder = placeholderText
        
        update(textFieldInitializer: textFieldInitializer)
        
        assert(validate?(text ?? "") ?? true)
        
        delegate = self
    }
    
    public init(defaultTextFieldInitializer: TextFieldInitializer? = JVTextField.defaultTextFieldInitializer) {
        super.init(frame: .zero)
        
        guard let defaultTextFieldInitializer = defaultTextFieldInitializer else { return }
        
        update(textFieldInitializer: defaultTextFieldInitializer)
    }
    
    public init(placeholderText: String) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        
        guard let defaultTextFieldInitializer = JVTextField.defaultTextFieldInitializer else { return }
        
        update(textFieldInitializer: defaultTextFieldInitializer)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func update(textFieldInitializer: TextFieldInitializer) {
        set(fontType: textFieldInitializer.fontType, placeholderText: textFieldInitializer.placeholderText, placeHolderTextFontType: textFieldInitializer.placeholderTextFontType)
        
        assert(validate?(text ?? "") ?? true)
    }
    
    open func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newValue: String
        
        // https://stackoverflow.com/questions/25621496/how-shouldchangecharactersinrange-works-in-swift
        // With the newValue property, we also want to include the added/removed character
        if let text = self.text, let textRange = Range(range, in: text) {
            newValue = text.replacingCharacters(in: textRange, with: string)
        } else {
            newValue = ""
        }
        
        let pressedBackSpaceAndHasPlaceHolderText = newValue == "" && placeholder != nil
        
        guard validate?(newValue) ?? true || pressedBackSpaceAndHasPlaceHolderText else { return false }
        
        currentValue = newValue
        
        hasChanged?(determineHasBeenChanged())
        
        return true
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didReturn?()
        
        return true
    }
}
