import UIKit

// MARK: - Enums

enum SelectedLanguageView {
    case source
    case target
}

class LanguageViewController: UIViewController {
    
    private var languages: [Language] = []
    private var sourceLanguage: Language?
    private var targetLanguage: Language?
    private var isChoosenSource: Bool = false
    private let backgroundColor: UIColor = UIColor(named: "blue")!
    private let selectedGray: UIColor = UIColor(named: "selectedGray")!
    private let radiusLayer: CGFloat = 40
    private let languageRadius: CGFloat = 35
    
    @IBOutlet private weak var sourceView: LanguageView!
    @IBOutlet private weak var targetView: LanguageView!
    @IBOutlet private weak var selectedLanguagesView: UIView!
    @IBOutlet private weak var searchLanguage: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        chooseSourceLanguage()
        createLanguages()
        
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        makeRoundCorners()
    }
    
    // MARK: - Actions
    
    @objc func didTouchSourceView(_ gesture: UITapGestureRecognizer) {
        chooseSourceLanguage()
    }
    
    @objc func didTouchTargetView(_ gesture: UITapGestureRecognizer) {
        chooseTargetLanguage()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        let sourceTapView = UITapGestureRecognizer(target: self, action: #selector(didTouchSourceView))
        sourceView.addGestureRecognizer(sourceTapView)
        
        let targetTapView = UITapGestureRecognizer(target: self, action: #selector(didTouchTargetView))
        targetView.addGestureRecognizer(targetTapView)
        
        tableView.delegate = self
        tableView.dataSource = self
       
        sourceView.languageImageViewCornerRadius = languageRadius
        targetView.languageImageViewCornerRadius = languageRadius
        
        makeRoundCorners()
        configureSearch()
    }
    
    private func configureSearch() {
        let textField = searchLanguage.value(forKey: "searchField") as! UITextField
        let glassIconView = textField.leftView as! UIImageView
        glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
        glassIconView.tintColor = .white
    }
    
    private func makeRoundCorners() {
        let path = UIBezierPath(roundedRect: selectedLanguagesView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radiusLayer, height: radiusLayer))
        let layerMask = CAShapeLayer()
        layerMask.path = path.cgPath
        selectedLanguagesView.layer.mask = layerMask
    }
    
    private func createLanguages() {
        languages.append(contentsOf: [Language(name: "Russian", flagPath: UIImage(named: "ru")),
                                      Language(name: "English", flagPath:  UIImage(named: "us")),
                                      Language(name: "Polish", flagPath: UIImage(named:  "pl")),
                                      Language(name: "Portuguese", flagPath: UIImage(named: "pt")),
                                      Language(name: "Romanian", flagPath: UIImage(named: "ro")),
                                      Language(name: "Norwegian", flagPath: UIImage(named: "no")),
                                      Language(name: "Ukrainian", flagPath: UIImage(named: "ua")),
                                      Language(name: "Turkish", flagPath: UIImage(named: "tr")),
                                      Language(name: "Slovak", flagPath: UIImage(named: "sk")),
                                      Language(name: "Slovenian", flagPath: UIImage(named: "sl"))])
    }
    
    private func chooseSourceLanguage() {
        isChoosenSource = true
        sourceView.backgroundColor = selectedGray
        targetView.backgroundColor = backgroundColor
    }
    
    private func chooseTargetLanguage() {
        isChoosenSource = false
        sourceView.backgroundColor = backgroundColor
        targetView.backgroundColor = selectedGray
    }
    
    private func updateChoosenLanguages() {
        if let sourceLanguage = sourceLanguage {
            sourceView.setup(with: sourceLanguage)
        }
        
        if let targetLanguage = targetLanguage {
            targetView.setup(with: targetLanguage)
        }
    }
}

// MARK: - Extensions

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        let language = languages[indexPath.row]
        cell.languageLabel.text = language.name
        cell.languageImageView.image = language.flagPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = languages[indexPath.row]
        if isChoosenSource {
            sourceLanguage = row
        } else {
            targetLanguage = row
        }
        updateChoosenLanguages()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


