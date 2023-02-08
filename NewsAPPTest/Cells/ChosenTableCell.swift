import UIKit

class ChosenTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    static let identifire = "ChosenTableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func configureLabel( titleText: String, dataText: String ) {
        
        titleLabel.text = titleText
        descriptionLabel.text = dataText
    }
    
    func configureImageView(link: String) {
        
        mainImageView.kf.indicatorType = .activity
        mainImageView.kf.setImage(with: URL(string: link))
    }
}
