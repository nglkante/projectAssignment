import UIKit
import PureLayout
import Kingfisher

class FightersCell: UICollectionViewCell {
    
    var fighter: FighterResponse? {
        didSet {
            guard let fighter = fighter else{return}
            fighterImage.kf.indicatorType = .activity
            fighterImage.kf.setImage(with: URL(string: fighter.photo!))
            nameLabel.text = "Name: " + (fighter.name ?? "N/A")
            nicknameLabel.text = "Nickname: " + (fighter.nickname ?? "N/A")
        }
    }
    
    static let identifier = "cellId"
    let container = UIView()
    let fighterImage = UIImageView()
    let nameLabel = UILabel()
    let nicknameLabel = UILabel()
    let ageLabel = UILabel()
    let gold = UIColor(red: 255/255.0, green: 215/255.0, blue: 0/255.0, alpha: 1.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(container)
        container.backgroundColor = .black
        container.layer.cornerRadius = 10
        container.autoPinEdge(toSuperviewSafeArea: .leading, withInset: 16.0)
        container.autoPinEdge(toSuperviewSafeArea: .trailing, withInset: 16.0)
        container.autoSetDimension(.height, toSize: 250)

        container.addSubview(nameLabel)
        container.addSubview(fighterImage)
        container.addSubview(nicknameLabel)

        fighterImage.contentMode = .scaleAspectFill
        fighterImage.clipsToBounds = true
        fighterImage.layer.cornerRadius = 10
        fighterImage.layer.borderColor = UIColor.gray.cgColor
        fighterImage.layer.borderWidth = 2.0
        fighterImage.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        fighterImage.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        fighterImage.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        fighterImage.autoSetDimension(.width, toSize: 350)
        
        nameLabel.textColor = gold
        nameLabel.textAlignment = .center
        nameLabel.autoPinEdge(.top, to: .bottom, of: fighterImage, withOffset: 8)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        
        nicknameLabel.textColor = gold
        nicknameLabel.textAlignment = .center
        nicknameLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 8)
        nicknameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: 32)
        nicknameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
