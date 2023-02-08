import Foundation

struct ArticleData: Codable {
    var results: [ResultData]?
}

struct ResultData: Codable {
    
    var uri: String?
    var url: String?
    var id: Int?
    var assetId: Int?
    var publishedDate: String?
    var updated: String?
    var section: String?
    var byline: String?
    var title: String?
    var abstract: String?
    var media: [MediaData]?
    
    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetId = "asset_id"
        case publishedDate = "published_date"
        case updated
        case section
        case byline
        case title
        case media
        case abstract
        
    }
}

struct MediaData: Codable {
    
    var subtype: String?
    var caption: String?
    var mediaMetadata: [MetaMediaData]?
    
    enum CodingKeys: String, CodingKey {
        case subtype
        case caption
        case mediaMetadata = "media-metadata"
    }
}

struct MetaMediaData: Codable {
    var urlImage: String?
    var format: String?
    
    enum CodingKeys: String, CodingKey {
        case urlImage = "url"
        case format
    }
    
}
