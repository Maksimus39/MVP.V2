import UIKit
import SDWebImage

protocol DetailsViewControllerProtocol: AnyObject { }
    

class DetailsViewController: UIViewController, DetailsViewControllerProtocol {
    var presenter: DetailsViewPresenterProtocol!
    
    private let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.backgroundColor = .systemGray6
        $0.layer.cornerRadius = 16
        return $0
    }(UIImageView())
    
    private let idLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        return $0
    }(UILabel())
    
    private let authorLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let urlLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureData()
        setupTapGesture()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemCyan
        title = "Детали фото"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(idLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(urlLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // ImageView
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.75),
            
            // ID Label
            idLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            idLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Author Label
            authorLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 12),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // URL Label
            urlLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            urlLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            urlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            urlLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
    }
    
    private func configureData() {
        let photo = presenter.itemPhoto
        idLabel.text = "ID: \(photo.id)"
        authorLabel.text = "Автор: \(photo.author)"
        urlLabel.text = photo.download_url
        
        
        imageView.sd_setImage(
            with: URL(string: photo.download_url),
            placeholderImage: UIImage(systemName: "photo.fill"),
            options: [],
            progress: { received, expected, _ in
                let percent = Float(received) / Float(expected)
                print("Загрузка фото: \(Int(percent * 100))%")
            },
            completed: { [weak self] image, error, _, _ in
                if let error = error {
                    print("Ошибка загрузки фото: \(error)")
                    self?.imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
                }
            }
        )
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(urlTapped))
        urlLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func urlTapped() {
        guard let urlString = presenter.itemPhoto.download_url as String?,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
