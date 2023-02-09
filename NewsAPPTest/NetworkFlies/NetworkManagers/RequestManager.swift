import Foundation
import Alamofire

class RequsetManager {
    
    static let shared = RequsetManager()
    private init () {}
    
    
    let emailedURL = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json?api-key=V7caABtIuV8C5pOWhS1XZRg4SFLkjodn"
    let sharedURL = "https://api.nytimes.com/svc/mostpopular/v2/shared/30/facebook.json?api-key=V7caABtIuV8C5pOWhS1XZRg4SFLkjodn"
    let viewedURL = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json?api-key=V7caABtIuV8C5pOWhS1XZRg4SFLkjodn"
    let ddefaultUrlImage = "https://www.nytimes.com/2023/02/01/magazine/menopause-hot-flashes-hormone-therapy.html"
    
    func sendEmailedRequest(url: String, completionSuccses: @escaping(ArticleData)->(), completionFailure: (()-> ())? ) {
        
        AF.request(url).responseDecodable(of: ArticleData.self) {  listOfNews in
        
            var article = ArticleData()
            switch listOfNews.result {
            case .success(let value):
                article = value
            case.failure(let error):
                print(error)
                if let hendlerFailure = completionFailure {
                    hendlerFailure()
                }
            }
            completionSuccses(article)
        }
    }
}
