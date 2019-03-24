// TODO: Better naming...
// This is split up in two protocols because of the generic constraints.
public protocol Changeable: AnyObject {
    
    /// Get notified when the row has changed values
    var hasChanged: ((_ hasNewValue: Bool) -> ())? { get set }
    
    /// Returns true if the row is changed, else false
    var isChanged: Bool { get }
    
    /// Reset the row to the initial state
    func reset()
    
    /// Set the old values to the current values.
    /// The old values are the current values.
    /// This gets called when the user wants to persist the changes he made.
    func updateFromCurrentState()
}

public protocol OldValue: AnyObject {
    associatedtype T: Equatable
    
     var oldValue: T { get set }
}

public protocol ChangeableValues: Changeable, OldValue {
    var currentValue: T { get set }
}

public extension ChangeableValues {
    var isChanged: Bool {
        return currentValue != oldValue
    }

    func reset() {
        // If you want to reset the current row, it should and must have an oldValue.
        currentValue = oldValue
    }
    
    func updateFromCurrentState() {
        oldValue = currentValue
    }
}
