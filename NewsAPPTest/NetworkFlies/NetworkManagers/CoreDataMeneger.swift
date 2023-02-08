import Foundation
import CoreData

// MARK: - Core Data stack
class CoreDataManager{
    var fetchResultController: NSFetchedResultsController<ResultsCoreData>!
    
    static let shared = CoreDataManager()
    private init () {}
    
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: viewContext)!
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NewsAPPTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func initialFetchResultController() {
        
        let fetchRequset = ResultsCoreData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequset.fetchLimit = 30
        fetchRequset.sortDescriptors = [sortDescriptor]
        
        fetchResultController = NSFetchedResultsController(
            fetchRequest: fetchRequset,
            managedObjectContext: persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        do {
            try fetchResultController.performFetch()
        } catch let error {
            print(error)}
        
    }
    
    func createUser(resultModel: ResultData, completion: @escaping()->()) {
        
        let article = ResultsCoreData(context: persistentContainer.viewContext)
        article.uri = resultModel.uri
        article.url = resultModel.url
        
        guard let result = resultModel.id else { return }
        article.id = Int64(result)
        article.title = resultModel.title
        article.byLine = resultModel.byline
        article.publeshedData = resultModel.publishedDate
        article.updateData = resultModel.updated
        article.section = resultModel.section
        
        guard let media = resultModel.media else { return }
        
        for item in media {
        
            let mediaCoreData = MediaCoreData(context: persistentContainer.viewContext)
            mediaCoreData.caption = item.caption
            mediaCoreData.subtype = item.subtype
            
            article.addToMediaCoreData(mediaCoreData)
            
            guard let mediaMetaData = item.mediaMetadata else { return }
            
            for value in mediaMetaData {
                let metaMediaCoreData = MetaMediaCoreData(context: persistentContainer.viewContext)
                metaMediaCoreData.urlImage = value.urlImage
                metaMediaCoreData.format = value.format
                
                mediaCoreData.addToMetaMediaCoreData(metaMediaCoreData)
            }
        }
        print(" AAAAAAAAAHJKGJHFHJDFRGRSDFAFFUIHLOIHUKUHTDSRDYHOJOIYGYDETRSYTTGIHOI \(article)")
        completion()
    }
}
