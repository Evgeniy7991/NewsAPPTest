import UIKit
import Kingfisher

class MostViewedTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    static let identifire = "MostViewedTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
        
    func configureElements(data: ResultData?) {
        
        guard let data else { return }
        titleLabel.text = data.title
        descriptionLabel.text = data.abstract
        descriptionView.layer.cornerRadius = 20
        mainImageView.layer.cornerRadius = 10
        
        mainImageView.kf.indicatorType = .activity
        guard let media = data.media else { return }
        guard let firstMedia = media.first else { return }
        guard let mediaMetaData = firstMedia.mediaMetadata else { return }
        guard let firstMediaMetaData = mediaMetaData.first else { return }
        
        mainImageView.kf.setImage(with: URL(string: firstMediaMetaData.urlImage ?? ""))
        
    }
}

