import UIKit
import SDWebImage

class ImageViewCell: UITableViewCell {
    static let reuseIdentifier: String = "ImageViewCell"
    
    lazy var cellImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .lightGray
        $0.image = UIImage(systemName: "photo")  
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellImage)
        contentView.backgroundColor = .clear
        setupConstraints()
    }
    
    func setupCell(url: String){
        cellImage.sd_setImage(with: URL(string: url)) { image, error, cacheType, imageURL in
            if let error = error {
                print("Ошибка загрузки: \(error.localizedDescription)")
                print("URL: \(url)")
            } else if image != nil {
                print("Картинка загружена: \(url)")
            }
        }
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            cellImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            cellImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            cellImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellImage.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



