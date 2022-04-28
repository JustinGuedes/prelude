#if canImport(UIKit)
import UIKit

public extension UIDevice {
    
    static var idiom: UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    static var isPad: Bool {
        return idiom == .pad
    }
    
    static var isPhone: Bool {
        return idiom == .phone
    }
    
}

#endif
