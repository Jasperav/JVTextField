import JVContentType
import JVFontUtils

public struct ContentTypeJVLabel: ContentType {

    public static var allTypes = Set<ContentTypeJVLabel>()
    
    public var contentTypeId: String?
    public var textAligment: NSTextAlignment = .natural
    public var initialText: String?
    public var numberOfLines = 1
    public var minimumScaleFactor: CGFloat = 0.0
    public var contentTypeTextFont: ContentTypeTextFont
    
    public init(contentTypeId: String?,
                contentTypeTextFont: ContentTypeTextFont,
                textAligment: NSTextAlignment = .natural,
                initialText: String? = nil,
                numberOfLines: Int = 1) {
        self.contentTypeId = contentTypeId
        self.textAligment = textAligment
        self.initialText = initialText
        self.numberOfLines = numberOfLines
        self.contentTypeTextFont = contentTypeTextFont
    }
    
    public func change(color: UIColor) -> ContentTypeJVLabel {
        var _copy = self
        
        _copy.contentTypeTextFont.color = color
        
        return _copy
    }
    
}
