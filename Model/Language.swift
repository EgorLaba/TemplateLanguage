import UIKit

struct Language {
    
    let languageCode: String
    
    var name: String { (Locale(identifier: languageCode) as NSLocale).displayName(forKey: .countryCode, value: languageCode)! }
    var flagImage: UIImage? { UIImage(named: languageCode) }
}





