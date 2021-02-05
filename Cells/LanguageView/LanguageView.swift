import UIKit

class LanguageView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var languageImageView: UIImageView!
    @IBOutlet private weak var languageNameLabel: UILabel!
    
    var languageImageViewCornerRadius: CGFloat {
        set { languageImageView.layer.cornerRadius = newValue }
        get { languageImageView.layer.cornerRadius }
    }
    
    var languageName: String? {
        set { languageNameLabel.text = newValue }
        get { languageNameLabel.text }
    }
    
    // MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromXib()
    }
    
    // MARK: - Public
    
    func setup(with language: Language) {
        languageNameLabel.text = language.name.uppercased()
        languageImageView.image = language.flagImage
    }
    
    func setImageViewCornerRadius(_ value: CGFloat) {
        languageImageView.layer.masksToBounds = true
        languageImageView.layer.cornerRadius = value
    }
    
    // MARK: - Private
    
    private func loadViewFromXib() {
        Bundle.main.loadNibNamed("LanguageView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
}


