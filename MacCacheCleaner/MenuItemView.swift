import AppKit

class MenuItemView: NSView {
    
    var onClick: ((NSClickGestureRecognizer) -> ())?
    
    private var gestureRecognizer: NSClickGestureRecognizer!
    
    // MARK: Life
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(clicked(_:)))
        addGestureRecognizer(gestureRecognizer)
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
    // MARK: - Actions
    
    @objc private func clicked(_ sender: NSClickGestureRecognizer) {
        onClick?(sender)
    }
}
