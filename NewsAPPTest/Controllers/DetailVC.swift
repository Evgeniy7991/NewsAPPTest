import UIKit

class DetailVC: UIViewController {
    //MARK: - @IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var publishedDateLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    
    //MARK: - let/var
    var resultData: ResultData?
    var resultModelObject: (ResultModel, MediaModel, MetaMediaModel)?
    var resultCoreDataObject: (ResultsCoreData, [MediaCoreData], [MetaMediaCoreData])?
    var flag: Bool?
    
    //MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if flag == true {
            configurePopularLabels()
            configurePopularImageView()
        } else {
            configureChosenLabels()
            configureChosenImageView()
        }
        print(flag)
    }
    
    //MARK: - Methods
    private func configurePopularLabels() {
    
        guard let resultData else { return }
        titleLabel.text = resultData.title
        sectionLabel.text = resultData.section
        guard let abstract = resultData.abstract else { return }
        abstractLabel.text = abstract + " " + abstract
        publishedDateLabel.text = resultData.publishedDate
        updateLabel.text = resultData.updated
        byLineLabel.text = resultData.byline
            
    }
    
    private func configurePopularImageView() {
        
        guard let resultData else { return }
        guard let media = resultData.media else { return }
        guard let firstMedia = media.first else { return }
        guard let mediaMetaData = firstMedia.mediaMetadata else { return }
        guard let firstMediaMetaData = mediaMetaData.first else { return }
        
        mainImageView.kf.indicatorType = .activity
        mainImageView.kf.setImage(with: URL(string: firstMediaMetaData.urlImage ?? ""))
    }
    
    private func configureChosenLabels() {
    
        guard let resultCoreDataObject else { return }
        titleLabel.text = resultCoreDataObject.0.title
        sectionLabel.text = resultCoreDataObject.0.section
        let abstract = resultCoreDataObject.0.abstract
        abstractLabel.text = (abstract ?? "") + " " + (abstract ?? "")
        publishedDateLabel.text = resultCoreDataObject.0.publeshedData
        updateLabel.text = resultCoreDataObject.0.updateData
        byLineLabel.text = resultCoreDataObject.0.byLine
            
    }
    
    private func configureChosenImageView() {
        
        guard let resultCoreDataObject else { return }
        
        mainImageView.kf.indicatorType = .activity
        guard let oneMetaMediaData = resultCoreDataObject.2.first else { return }
        mainImageView.kf.setImage(with: URL(string: oneMetaMediaData.urlImage ?? ""))
    }
}


