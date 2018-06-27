import AppKit

class MenuItemView: NSView {
    
    var onClick: ((NSClickGestureRecognizer) -> ())?
    
    private var gestureRecognizer: NSClickGestureRecognizer!

    override func awakeFromNib() {
        super.awakeFromNib()
        gestureRecognizer = NSClickGestureRecognizer(target: self, action: #selector(clicked(_:)))
        addGestureRecognizer(gestureRecognizer)
    }
    
    override func acceptsFirstMouse(for event: NSEvent?) -> Bool {
        return true
    }
    
    @objc private func clicked(_ sender: NSClickGestureRecognizer) {
        onClick?(sender)
    }
}
