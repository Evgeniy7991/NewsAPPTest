import Foundation
import CoreData


extension MetaMediaCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetaMediaCoreData> {
        return NSFetchRequest<MetaMediaCoreData>(entityName: "MetaMediaCoreData")
    }

    @NSManaged public var format: String?
    @NSManaged public var urlImage: String?
    @NSManaged public var mediaCoreData: MediaCoreData?
    
}
