import UIKit
import JVCurrentDevice
import JVContentType
import JVSizeable
import JVConstraintEdges

open class JVLabel: UILabel {
    
    public let contentType: ContentTypeJVLabel

    public init(contentType: ContentTypeJVLabel, text: String? = nil) {
        self.contentType = contentType
        
        super.init(frame: CGRect.zero)
        
        self.text = text
        
        numberOfLines = contentType.numberOfLines
        minimumScaleFactor = contentType.minimumScaleFactor
        
        mirrorAligmentIfRightToLeftLanguage()
        
        if minimumScaleFactor != 0.0 {
            adjustsFontSizeToFitWidth = true
        }
        
        if self.text!.isEmpty && !(contentType.initialText?.isEmpty ?? true) {
            self.text = contentType.initialText
        }

        change(contentType: contentType.contentTypeTextFont)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError() // TODO: Unsupported()
    }
    
    func change(contentType: ContentTypeTextFont) {
        font = contentType.font
        textColor = contentType.color
    }
}
