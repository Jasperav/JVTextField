public extension String {
    
    var contentTypeJVLabel: ContentTypeJVLabel {
        get {
            return ContentTypeJVLabel.getContentType(contentTypeId: self)
        }
    }
    
    var contentTypeTextFont: ContentTypeTextFont {
        get {
            return ContentTypeTextFont.getContentType(contentTypeId: self)
        }
    }
}
