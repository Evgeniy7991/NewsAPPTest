import Foundation
import UIKit

extension UIViewController {
    
    func addDefaultAlert (title: String, message: String, defaultTitle: String = "Ok", cancelTitle: String = "Cancel", okAction: (() -> Void)?, cancelAction: (()-> Void)?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: defaultTitle, style: .default) { (_) in
            guard let action = okAction else { return }
            action()
        }
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
            guard let action = cancelAction else { return }
            action()
        }
        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

