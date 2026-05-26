import UIKit

protocol ViewControllerProtocol: AnyObject {
    func updateTable()
}

// UIViewController -> View
class ViewController: UIViewController, ViewControllerProtocol {
    var presenter: MainViewPresenterProtocol?
    lazy var tableView: UITableView = {
        $0.register(ImageViewCell.self, forCellReuseIdentifier: ImageViewCell.reuseIdentifier)
        $0.dataSource = self
        return $0
    }(UITableView(frame: view.frame, style: .plain))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        presenter?.getPhotoData()
    }

    func updateTable() {
            self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.photoData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageViewCell.reuseIdentifier, for: indexPath) as! ImageViewCell
        let photoUrl = presenter?.photoData[indexPath.row].download_url
        cell.setupCell(url: photoUrl ?? "")
        print(cell)
        return cell
    }
}

