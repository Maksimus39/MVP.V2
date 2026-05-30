import UIKit

protocol ViewControllerProtocol: AnyObject {
    func updateImages()
}

final class ViewController: UIViewController, ViewControllerProtocol {
   var presenter: MainViewPresenterProtocol!
    
    lazy var collectionView: UICollectionView = {
        let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
        layout?.itemSize = CGSize(width: (((view.frame.width - 20) - 10) / 2), height: 200)
        layout?.minimumLineSpacing = 10
        layout?.minimumInteritemSpacing = 10
        layout?.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        
        $0.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        $0.dataSource = self
        $0.delegate = self
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        $0.backgroundColor = .systemCyan
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        presenter.fetchImageData()
    }
    
    func updateImages() {
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as! PhotoCell
        cell.setupCell(cart: presenter.images[indexPath.item])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(presenter.images[indexPath.item])
        
        let detailsVC = Assembly.makeDetailsViewController(itemPhoto: presenter.images[indexPath.item])
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

