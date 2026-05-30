import UIKit
import SDWebImage

final class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier: String = "PhotoCell"
    lazy var imageView: UIImageView = {
        $0.frame.size = frame.size
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        //$0.isUserInteractionEnabled = true
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 25
        return $0
    }(UIImageView())
    let progressView = UIProgressView(progressViewStyle: .default)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(progressView)
    
        progressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(cart: API.Photo) {
        progressView.progress = 0
        progressView.isHidden = false
        
        imageView.sd_setImage(
            with: URL(string: cart.download_url),
            placeholderImage: UIImage(systemName: "photo.fill"),
            progress: { [weak self] receivedSize, expectedSize, _ in
                let progress = Float(receivedSize) / Float(expectedSize)
                DispatchQueue.main.async {
                    self?.progressView.progress = progress
                }
            },
            completed: { [weak self] _, _, _, _ in
                self?.progressView.isHidden = true
            }
        )
    }
}
