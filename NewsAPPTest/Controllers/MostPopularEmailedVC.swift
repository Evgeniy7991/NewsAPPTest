import UIKit

class MostPopularEmailedVC: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var mostPopularTableView: UITableView!
    
    //MARK: - let/var
    let requestManager = RequsetManager.shared
    let coreDataManager = CoreDataManager.shared
    var articleData = ArticleData()
    
    //MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestManager.sendEmailedRequest(url: requestManager.emailedURL, completionSuccses: { [weak self]  articleData  in
            guard let self else { return }
            self.articleData = articleData
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
        
        guard let results = articleData.results else { return 0 }
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MostEmailedTableCell.identifire, for: indexPath) as? MostEmailedTableCell else { return UITableViewCell() }
        guard let results = self.articleData.results else { return UITableViewCell() }
        
        cell.configureElements(data: results[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let results = self.articleData.results else { return }
        pushDetailVC(result: results[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let swipeFavourite = UIContextualAction(style: .destructive, title: "Save") { [weak self] (action, view, completion) in
            
            guard let self else { return }
            guard let results = self.articleData.results else { return }
        
            self.coreDataManager.createArticle(resultModel: results[indexPath.row]) {
                self.coreDataManager.saveContext()
                completion(true)
            }
        }
        
        swipeFavourite.backgroundColor = .purple
        swipeFavourite.image = UIImage(systemName: "star.circle.fill")
        return UISwipeActionsConfiguration(actions: [swipeFavourite])
    }
}


