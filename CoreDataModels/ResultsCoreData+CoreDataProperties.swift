import Foundation
import CoreData


extension ResultsCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultsCoreData> {
        return NSFetchRequest<ResultsCoreData>(entityName: "ResultsCoreData")
    }

    @NSManaged public var assetid: Int64
    @NSManaged public var id: Int64
    @NSManaged public var abstract: String?
    @NSManaged public var byLine: String?
    @NSManaged public var publeshedData: String?
    @NSManaged public var section: String?
    @NSManaged public var title: String?
    @NSManaged public var updateData: String?
    @NSManaged public var uri: String?
    @NSManaged public var url: String?
    @NSManaged public var isChosen: Bool
    @NSManaged public var mediaCoreData: NSSet?

}

// MARK: Generated accessors for mediaCoreData
extension ResultsCoreData {

    @objc(addMediaCoreDataObject:)
    @NSManaged public func addToMediaCoreData(_ value: MediaCoreData)

    @objc(removeMediaCoreDataObject:)
    @NSManaged public func removeFromMediaCoreData(_ value: MediaCoreData)

    @objc(addMediaCoreData:)
    @NSManaged public func addToMediaCoreData(_ values: NSSet)

    @objc(removeMediaCoreData:)
    @NSManaged public func removeFromMediaCoreData(_ values: NSSet)

}
