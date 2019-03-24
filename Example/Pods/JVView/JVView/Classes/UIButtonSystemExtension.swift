public extension UIButton {
    func set(contentType: ContentTypeTextFont, text: String) {
        assert(buttonType == .system)
        
        titleLabel!.font = contentType.font
        
        setTitle(text, for: .normal)
    }
}
