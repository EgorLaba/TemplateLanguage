import UIKit

fileprivate extension LanguageTableViewCell {
    struct Constants {
        static let radiusImage: CGFloat = 25
    }
}

class LanguageTableViewCell: UITableViewCell {
    @IBOutlet private weak var languageImageView: UIImageView!
    @IBOutlet private weak var languageNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        languageImageView?.layer.cornerRadius = Constants.radiusImage
    }
    
    func configureCell(_ language: Language) {
        languageNameLabel.text = language.name
        languageImageView.image = language.flagImage
    }
}
