import UIKit

class LanguageCell: UITableViewCell {
    
    // MARK: - Variables
    
    private var radius: CGFloat = 20
    
    // MARK: - Outlets
    
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageLabel: UILabel!
    
    
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        languageImageView?.layer.cornerRadius = radius
    }
}
