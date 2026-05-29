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
        $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return $0
    }(UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        return cell
    }
}

