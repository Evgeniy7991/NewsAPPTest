import Foundation
import CoreData

struct CoreDataConverter {
    
    func convertCoredata(article: ResultsCoreData?) -> (ResultsCoreData, [MediaCoreData], [MetaMediaCoreData])? {
        
        var array: [MediaCoreData] = []
        var array2: [MetaMediaCoreData] = []
        
        guard let article else { return nil }
        guard let mediaCoreData = article.mediaCoreData else { return nil }
        
        for item in mediaCoreData {
            
            guard let newItem = item as? MediaCoreData else { return nil }
            guard let metaMediaCoreData = newItem.metaMediaCoreData else { return nil }
            
            for value in metaMediaCoreData  {
                
                guard let newValue = value as? MetaMediaCoreData else { return nil }
                array2.append(newValue)
            }
            
            array.append(newItem)
        }
        
        return (article, array, array2)
    }
}
    
    
    
