import UIKit
import CoreData

class ChosenVC: UIViewController {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var chosenTableView: UITableView!
    
    //MARK: - let/var
    let requestManager = RequsetManager.shared
    let coreDataManager = CoreDataManager.shared
    let coreDateConverter = CoreDataConverter()
    let firstPartMessage = "To add your favorite you need to swipe to the left in previous screen. Good luck!"
    let secondPartMessage = " Please swipe to the right to add the faforite article to your favorites. Good luck!"
    var result = ResultData()
    var marker = false
    
    //MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.tabBarController?.tabBar.isHidden = true
        coreDataManager.initialFetchResultController()
    }
    
    //MARK: - Methods
    private func pushDetailVC(object: (ResultsCoreData, [MediaCoreData], [MetaMediaCoreData])) {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else  { return }
        controller.resultCoreDataObject = object
        controller.flag = false
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - UITableViewDelegate
extension ChosenVC:UITableViewDataSource {
    
}
//MARK: - UITableViewDataSource
extension ChosenVC: UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return coreDataManager.fetchResultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = coreDataManager.fetchResultController.sections?[section]
        let numberOfObjects = sectionInfo?.numberOfObjects
        
        if numberOfObjects != 0 {
            return numberOfObjects ?? 0
        } else {
            self.addDefaultAlert(
                title: "Attention!",
                message: firstPartMessage,
                okAction: {
                    self.navigationController?.popToRootViewController(animated: true)
                },
                cancelAction: {
                    self.navigationController?.popToRootViewController(animated: true)
                })
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChosenTableCell.identifire, for: indexPath) as? ChosenTableCell else { return UITableViewCell() }
        
        let article = coreDataManager.fetchResultController.object(at: indexPath)
        guard let convertObjects = coreDateConverter.convertCoredata(article: article) else { return UITableViewCell () }
        
        cell.configureLabel(
            titleText: convertObjects.0.title ?? "",
            dataText: convertObjects.0.title ?? ""
        )
        
        cell.configureImageView(link: convertObjects.2[1].urlImage ?? requestManager.ddefaultUrlImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = coreDataManager.fetchResultController.object(at: indexPath)
        guard let convertObjects = coreDateConverter.convertCoredata(article: article) else { return }
        
        pushDetailVC(object: convertObjects)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
            let article = coreDataManager.fetchResultController.object(at: indexPath)
            coreDataManager.persistentContainer.viewContext.delete(article)
            coreDataManager.saveContext()
        } else {
            
        }
    }
}

extension ChosenVC: NSFetchedResultsControllerDelegate {
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            chosenTableView.deleteRows(at: [indexPath!], with: .middle)
        default:
            break
        }
    }
}


