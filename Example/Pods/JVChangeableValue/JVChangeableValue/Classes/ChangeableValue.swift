// TODO: Better naming...
// This is split up in two protocols because of the generic constraints.
public protocol Changeable: AnyObject {
    var hasChanged: ((Bool) -> ())? { get set }
    
    func determineHasBeenChanged() -> Bool
    func reset()
}

public protocol OldValue {
    associatedtype T: Equatable
    
     var oldValue: T { get }
}

public protocol ChangeableValues: Changeable, OldValue {
    var currentValue: T { get set }
}

public extension ChangeableValues {
    func determineHasBeenChanged() -> Bool {
        return currentValue != oldValue
    }
    
    func reset() {
        // If you want to reset the current row, it should and must have an oldValue.
        currentValue = oldValue
    }
}
