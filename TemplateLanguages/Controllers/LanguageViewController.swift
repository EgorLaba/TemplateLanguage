import UIKit

class LanguageViewController: UIViewController {
    
    // MARK: - Variables
    
    private var languages: [Language] = []
    
    private var sourceLanguage: Language?
    private var targetLanguage: Language?
    
    private var isChoosenSource: Bool = false
    private let backgroundColor: UIColor = UIColor(named: "blue")!
    private let selectedGray: UIColor = UIColor(named: "selectedGray")!
    private let alpha: CGFloat = 0.5
    private let radius: CGFloat = 30
    private let languageRadius: CGFloat = 40
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var sourceView: UIView!
    @IBOutlet weak var targetView: UIView!
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var targetImageView: UIImageView!
    @IBOutlet weak var sourceNameLabel: UILabel!
    @IBOutlet weak var targetNameLabel: UILabel!
    @IBOutlet weak var selectedLanguagesView: UIView!
    @IBOutlet weak var searchLanguage: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseSourceLanguage()
        createLanguages()
        
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundCorners()
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
        
        
        roundCorners()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sourceImageView.layer.cornerRadius = languageRadius
        targetImageView.layer.cornerRadius = languageRadius
    }
    
    private func roundCorners() {
        let path = UIBezierPath(roundedRect: selectedLanguagesView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        selectedLanguagesView.layer.mask = mask
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
        sourceImageView.image = sourceLanguage?.flagPath
        sourceNameLabel.text = sourceLanguage?.name.uppercased()
        targetImageView.image = targetLanguage?.flagPath
        targetNameLabel.text = targetLanguage?.name.uppercased()
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


