import Foundation
import CoreData


extension MediaCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaCoreData> {
        return NSFetchRequest<MediaCoreData>(entityName: "MediaCoreData")
    }

    @NSManaged public var caption: String?
    @NSManaged public var subtype: String?
    @NSManaged public var metaMediaCoreData: NSSet?
    @NSManaged public var resultsCoreData: ResultsCoreData?

}

// MARK: Generated accessors for metaMediaCoreData
extension MediaCoreData {

    @objc(addMetaMediaCoreDataObject:)
    @NSManaged public func addToMetaMediaCoreData(_ value: MetaMediaCoreData)

    @objc(removeMetaMediaCoreDataObject:)
    @NSManaged public func removeFromMetaMediaCoreData(_ value: MetaMediaCoreData)

    @objc(addMetaMediaCoreData:)
    @NSManaged public func addToMetaMediaCoreData(_ values: NSSet)

    @objc(removeMetaMediaCoreData:)
    @NSManaged public func removeFromMetaMediaCoreData(_ values: NSSet)

}
