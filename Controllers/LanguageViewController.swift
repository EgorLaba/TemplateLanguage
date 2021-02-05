import UIKit

// MARK: - Enums

enum SelectedLanguageView {
    case source
    case target
}

fileprivate extension LanguageViewController {
    struct Constants {
        static let languagesArray: [Language] = [
            "ru",
            "no",
            "pl",
            "pt",
            "ro",
            "us",
            "ua",
            "tr",
            "sk",
            "sl"
        ].compactMap { Language(languageCode: $0) }
    }
}

class LanguageViewController: UIViewController {
    private var languages: [Language] { Constants.languagesArray }
    private var sourceLanguage: Language = Constants.languagesArray[0]
    private var targetLanguage: Language = Constants.languagesArray[1]
    private var selectedLanguageView: SelectedLanguageView = .source
    
    private let heightForRow: CGFloat = 100
    private let backgroundColor: UIColor = UIColor(named: "blue")!
    private let selectedGray: UIColor = UIColor(named: "selectedGray")!
    private let cornerRadii: CGFloat = 40
    private let languageImageRadius: CGFloat = 35
    
    @IBOutlet private weak var sourceView: LanguageView!
    @IBOutlet private weak var targetView: LanguageView!
    @IBOutlet private weak var selectedLanguagesView: UIView!
    @IBOutlet private weak var searchLanguage: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        updateChoosenLanguages()
        selectLanguageView(sourceView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        makeRoundCorners()
    }
    
    // MARK: - Actions
    
    @objc func didTouchSourceView(_ gesture: UITapGestureRecognizer) {
        selectedLanguageView = .source
        deselectLanguageView(targetView)
        selectLanguageView(sourceView)
    }
    
    @objc func didTouchTargetView(_ gesture: UITapGestureRecognizer) {
        selectedLanguageView = .target
        deselectLanguageView(sourceView)
        selectLanguageView(targetView)
    }
    
    // MARK: - Private
    
    private func configureUI() {
        let sourceTapView = UITapGestureRecognizer(target: self, action: #selector(didTouchSourceView))
        sourceView.addGestureRecognizer(sourceTapView)
        
        let targetTapView = UITapGestureRecognizer(target: self, action: #selector(didTouchTargetView))
        targetView.addGestureRecognizer(targetTapView)
        
        sourceView.languageImageViewCornerRadius = languageImageRadius
        targetView.languageImageViewCornerRadius = languageImageRadius
        
        configureSearch()
        
        tableView.register(LanguageTableViewCell.self)
    }
    
    private func configureSearch() {
        guard let textField = searchLanguage.value(forKey: "searchField") as? UITextField else { fatalError() }
        
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = .white
    }
    
    private func makeRoundCorners() {
        let layerMask = CAShapeLayer()
        
        layerMask.path = UIBezierPath(
            roundedRect: selectedLanguagesView.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadii, height: cornerRadii)
        ).cgPath
        
        selectedLanguagesView.layer.mask = layerMask
    }
    
    private func updateChoosenLanguages() {
        sourceView.setup(with: sourceLanguage)
        targetView.setup(with: targetLanguage)
    }
    
    private func selectLanguageView(_ view: UIView) {
        view.backgroundColor = selectedGray
    }
    
    private func deselectLanguageView(_ view: UIView) {
        sourceView.backgroundColor = backgroundColor
    }
}

// MARK: - Extensions

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: LanguageTableViewCell.self, for: indexPath)
        
        let language = languages[indexPath.row]
        cell.configureCell(language)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = languages[indexPath.row]
        
        switch selectedLanguageView {
            case .source:
                sourceLanguage = row
                sourceView.setup(with: sourceLanguage)
            case .target:
                targetLanguage = row
                targetView.setup(with: targetLanguage)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
}

