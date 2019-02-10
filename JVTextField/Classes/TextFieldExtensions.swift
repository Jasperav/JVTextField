import JVView

public extension UITextField {
    func set(fontType: ContentTypeTextFont, placeholderText: String, placeHolderTextFontType: ContentTypeTextFont) {
        self.placeholder = placeholderText
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.font : placeHolderTextFontType.font,
                                                                                              .foregroundColor: placeHolderTextFontType.color])
        
        self.font = fontType.font
        self.textColor = fontType.color
    }
}
