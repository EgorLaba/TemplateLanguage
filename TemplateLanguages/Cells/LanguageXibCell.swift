import UIKit

class LanguageXibCell: UITableViewCell {
    
    // MARK: - Variables
    
    private let languageRadius: CGFloat = 40
    private var sourceLanguage: Language?
    private var targetLanguage: Language?

    
    // MARK: - Outlets
    
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        languageImageView.layer.cornerRadius = languageRadius
        languageNameLabel.layer.cornerRadius = languageRadius
    }
    
    // MARK: - Private
    
    private func updateChoosenLanguages() {
        languageImageView.image = sourceLanguage?.flagPath
        languageNameLabel.text = sourceLanguage?.name.uppercased()
    }
}
