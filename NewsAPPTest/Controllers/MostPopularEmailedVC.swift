import UIKit

class MostPopularEmailedVC: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var mostPopularTableView: UITableView!
    //MARK: - let/var
    var popularEmailedArray = [ResultData]()
    let requestManager = RequsetManager.shared
    let coreDataManager = CoreDataManager.shared
    //MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestManager.sendEmailedRequest(url: requestManager.emailedURL, completionSuccses: { [ weak self] results in
            guard let self else { return }
            self.popularEmailedArray = results
            self.mostPopularTableView.reloadData()
        }, completionFailure: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.tabBarController?.tabBar.isHidden = false
    }
    //MARK: - Methods
    private func pushDetailVC(result: ResultData) {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else  { print("Error"); return }
        controller.resultData = result
        controller.flag = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

    //MARK: - UITableViewDelegate
extension MostPopularEmailedVC: UITableViewDelegate {
    
}
    //MARK: - UITableViewDataSource
extension MostPopularEmailedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return popularEmailedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MostEmailedTableCell.identifire, for: indexPath) as? MostEmailedTableCell else { return UITableViewCell() }
        
        let row = popularEmailedArray[indexPath.row]
        cell.configureElements(data: row)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataRow = popularEmailedArray[indexPath.row]
        pushDetailVC(result: dataRow)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeFavourite = UIContextualAction(style: .destructive, title: "Save") { [weak self] (action, view, completion) in
            guard let self else { return }
            
            let dataRow = self.popularEmailedArray[indexPath.row]
            self.coreDataManager.createUser(resultModel: dataRow) {
                self.coreDataManager.saveContext()
                completion(true)
            }
        }
        
        swipeFavourite.backgroundColor = .purple
        swipeFavourite.image = UIImage(systemName: "star.circle.fill")
        return UISwipeActionsConfiguration(actions: [swipeFavourite])
    }
}


