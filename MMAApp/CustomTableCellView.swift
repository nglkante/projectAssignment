import UIKit
import PureLayout

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "cellId"
    
    let container = UIView()
    let weightClassLabel = UILabel()
    let redBoxingGloveImageView = UIImageView(image: UIImage(named: "redGlove"))
    let blueBoxingGloveImageView = UIImageView(image: UIImage(named: "blueGlove"))
    let gold = UIColor(red: 255/255.0, green: 215/255.0, blue: 0/255.0, alpha: 1.0)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        weightClassLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(container)
        container.backgroundColor = .black
        container.layer.cornerRadius = 20
        container.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 50)
        container.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 50)
        container.autoSetDimension(.height, toSize: 50)
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.borderWidth = 2.0
        
        container.addSubview(weightClassLabel)
        container.addSubview(redBoxingGloveImageView)
        container.addSubview(blueBoxingGloveImageView)

        
        weightClassLabel.textColor = gold
        weightClassLabel.textAlignment = .center
        weightClassLabel.font = UIFont.boldSystemFont(ofSize: 20)
        weightClassLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 12)
        weightClassLabel.autoPinEdge(toSuperviewEdge: .leading, withInset: 12)
        weightClassLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 12)

        redBoxingGloveImageView.contentMode = .scaleAspectFit
        redBoxingGloveImageView.clipsToBounds = true
        redBoxingGloveImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        redBoxingGloveImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
        redBoxingGloveImageView.autoSetDimension(.width, toSize: 20)
        redBoxingGloveImageView.autoSetDimension(.height, toSize: 20)
        
        blueBoxingGloveImageView.contentMode = .scaleAspectFit
        blueBoxingGloveImageView.clipsToBounds = true
        blueBoxingGloveImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 16)
        blueBoxingGloveImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        blueBoxingGloveImageView.autoSetDimension(.width, toSize: 20)
        blueBoxingGloveImageView.autoSetDimension(.height, toSize: 20)
    }
    
    override func prepareForReuse() {
        weightClassLabel.text = ""
    }
    
    func set(weightClass: String) {
        weightClassLabel.text = weightClass
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
