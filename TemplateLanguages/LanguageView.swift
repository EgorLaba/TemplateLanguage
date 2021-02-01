import UIKit

class LanguageView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var languageImageView: UIImageView!
    @IBOutlet weak var languageNameLabel: UILabel!
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromXib()
    }
    
    // MARK: - Private
    
    private func loadViewFromXib() {
        let viewFromXib = Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)?[0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}


