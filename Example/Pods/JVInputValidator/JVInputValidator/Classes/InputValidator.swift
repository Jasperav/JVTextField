public enum ValidationState {
    case valid, invalid
    
    public mutating func update(isValid: Bool) {
        if isValid {
            self = .valid
        } else {
            self = .invalid
        }
    }
}

public protocol InputValidator {
    var validationState: ValidationState { get }
}
