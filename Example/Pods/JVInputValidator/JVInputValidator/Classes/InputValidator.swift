public enum ValidationState {
    case valid, invalid
}

public struct InputValidator {
    public private (set) var validationState: ValidationState
    public var changedValidationState: ((ValidationState) -> ())?
    
    public init(validationState: ValidationState) {
        self.validationState = validationState
    }
    
    public mutating func update(isValid: Bool) {
        if isValid {
            validationState = .valid
        } else {
            validationState = .invalid
        }
        
        changedValidationState?(validationState)
    }
    
    public mutating func update(state: ValidationState) {
        validationState = state
        
        changedValidationState?(validationState)
    }
}

public protocol InputValidateable {
    var inputValidator: InputValidator { get set }
}
