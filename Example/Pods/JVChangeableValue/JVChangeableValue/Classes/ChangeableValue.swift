// TODO: Better naming...
// This is split up in two protocols because of the generic constraints.
public protocol Changeable: AnyObject {
    var hasChanged: ((Bool) -> ())? { get set }
    
    func determineHasBeenChanged() -> Bool
    func reset()
}

public protocol ChangeableValues: Changeable {
    associatedtype T: Equatable
    
    var currentValue: T { get set }
    var oldValue: (() -> (T))? { get }
}

public extension ChangeableValues {
    func determineHasBeenChanged() -> Bool {
        return currentValue != oldValue!()
    }
    
    func reset() {
        // If you want to reset the current row, it should and must have an oldValue.
        currentValue = oldValue!()
    }
}
