import JVView

public struct TextFieldInitializer {
    public let fontType: ContentTypeTextFont
    public let placeholderText: String
    public let placeholderTextFontType: ContentTypeTextFont
    
    public init(fontType: ContentTypeTextFont, placeholderText: String, placeholderTextFontType: ContentTypeTextFont) {
        self.fontType = fontType
        self.placeholderText = placeholderText
        self.placeholderTextFontType = placeholderTextFontType
    }
}
