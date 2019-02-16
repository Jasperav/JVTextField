import UIKit
import JVConstraintEdges
import JVView
import JVChangeableValue
import JVInputValidator

open class JVTextField: UITextField, UITextFieldDelegate, ChangeableValues, InputValidateable {
    
    public static var defaultTextFieldInitializer: TextFieldInitializer?
    
    public var currentValue = ""
    public var oldValue = ""
    public var hasChanged: ((Bool) -> ())?
    
    /// Will actually block input of the user.
    public var validationBlockUserInput: ((String) -> (Bool))
    
    /// Won't block input of the user, but changes the validation state
    public var validationToChangeValidationState: ((String) -> (Bool))
    
    public var inputValidator = InputValidator(validationState: .valid)
    
    public var didReturn: (() -> ())?
    
    public init(textFieldInitializer: TextFieldInitializer = JVTextField.defaultTextFieldInitializer!,
                text: String? = nil,
                validationBlockUserInput: @escaping ((String) -> (Bool)),
                validationToChangeValidationState: ((String) -> (Bool))? = nil,
                placeholderText: String? = nil) {
        self.validationBlockUserInput = validationBlockUserInput
        self.validationToChangeValidationState = validationToChangeValidationState ?? validationBlockUserInput
        
        super.init(frame: .zero)
        
        self.text = text
        self.placeholder = placeholderText
        
        update(textFieldInitializer: textFieldInitializer)
        
        assert(self.validationBlockUserInput(string))
        
        delegate = self
        
        guard let text = text else { return }
        
        updateValidationState()
        assert(self.validationBlockUserInput(text))
    }
    
    public init() {
        self.validationBlockUserInput = { _ in return false }
        self.validationToChangeValidationState = { _ in return false }
        
        super.init(frame: .zero)
    }
    
    public init(placeholderText: String, validationBlockUserInput: @escaping ((String) -> (Bool)), validationToChangeValidationState: ((String) -> (Bool))? = nil) {
        self.validationBlockUserInput = validationBlockUserInput
        self.validationToChangeValidationState = validationToChangeValidationState ?? validationBlockUserInput
        
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
        
        guard validationBlockUserInput(newValue) || pressedBackSpaceAndHasPlaceHolderText else { return false }
        
        currentValue = newValue
        
        updateValidationState()
        
        hasChanged?(determineHasBeenChanged())
        
        return true
    }
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didReturn?()
        
        return true
    }
    
    private func updateValidationState() {
        inputValidator.update(isValid: validationToChangeValidationState(string))
    }
}
