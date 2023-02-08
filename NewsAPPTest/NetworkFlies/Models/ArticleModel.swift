import Foundation

struct ArticleModel{
    var results: ResultModel 
}

struct ResultModel {
    
    var uri: String
    var url: String
    var id: Int
    var assetId: Int
    var publishedDate: String
    var updated: String
    var section: String
    var byline: String
    var title: String
    var abstract: String
    var media: [MediaModel]
}

struct MediaModel {
    
    var subtype: String
    var caption: String
    var mediaMetadata: [MetaMediaModel]
}

struct MetaMediaModel{
    var urlImage: String
    var format: String
}
