import Foundation

class NativeViewFactory : NSObject, FlutterPlatformViewFactory {
    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?) -> FlutterPlatformView {
        return NativeView(frame)
    }
}

public class NativeView: NSObject, FlutterPlatformView {
    let frame: CGRect
    
    init(_ frame: CGRect) {
        self.frame = frame
    }
    
    public func view() -> UIView {
        let tv = UITextView(Frame: frame)
        tv.text = "Hello from IOS"
        return tv
    }
}
