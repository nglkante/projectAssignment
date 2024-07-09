import UIKit
import Combine
import Kingfisher
import PureLayout

class FighterDetailsViewController: UIViewController {
    
    var viewModel: FighterDetailsViewModel
    var disposables = Set<AnyCancellable>()
    
    let fighterImageView = UIImageView()
    let backgroundImageView = UIImageView(image: UIImage(named: "Spray"))
    let gradientLayer = CAGradientLayer()
    
    let nameLabel = UILabel()
    let nicknameLabel = UILabel()
    let ageLabel = UILabel()
    let heightLabel = UILabel()
    let weightLabel = UILabel()
    let reachLabel = UILabel()
    let stanceLabel = UILabel()
    let teamLabel = UILabel()
    let categoryLabel = UILabel()
    
    let stackView = UIStackView()
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let gold = UIColor(red: 255/255.0, green: 215/255.0, blue: 0/255.0, alpha: 1.0)
    
    init(viewModel: FighterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        styleViews()
        layoutViews()
        configureDetails()
        bindViewModel()
        navigationController?.setTitleColor(gold)
    }
    
    func setupViews() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nicknameLabel)
        stackView.addArrangedSubview(ageLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(reachLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(categoryLabel)
        stackView.addArrangedSubview(stanceLabel)
        stackView.addArrangedSubview(teamLabel)
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(fighterImageView)
        backgroundImageView.layer.addSublayer(gradientLayer)
        contentView.addSubview(stackView)
    }
    
    func styleViews() {
        fighterImageView.contentMode = .scaleAspectFill
        fighterImageView.clipsToBounds = true
        fighterImageView.layer.cornerRadius = 10
        fighterImageView.layer.borderColor = UIColor.gray.cgColor
        fighterImageView.layer.borderWidth = 2.0
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.2).cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        nameLabel.textColor = gold
        nicknameLabel.textColor = gold
        ageLabel.textColor = gold
        heightLabel.textColor = gold
        weightLabel.textColor = gold
        reachLabel.textColor = gold
        stanceLabel.textColor = gold
        teamLabel.textColor = gold
        categoryLabel.textColor = gold
        
        nameLabel.textAlignment = .center
        nicknameLabel.textAlignment = .center
        ageLabel.textAlignment = .center
        heightLabel.textAlignment = .center
        weightLabel.textAlignment = .center
        reachLabel.textAlignment = .center
        stanceLabel.textAlignment = .center
        teamLabel.textAlignment = .center
        categoryLabel.textAlignment = .center
        
        title = "Fighter info"
    }
    
    func layoutViews() {
        scrollView.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        
        fighterImageView.autoPinEdge(toSuperviewSafeArea: .top, withInset: 20)
        fighterImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        fighterImageView.autoSetDimensions(to: CGSize(width: 350, height: 350))
        
        backgroundImageView.autoPinEdge(.top, to: .bottom, of: fighterImageView, withOffset: -100)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        backgroundImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
        stackView.autoPinEdge(.top, to: .bottom, of: fighterImageView, withOffset: 20)
        stackView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        stackView.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        stackView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 20)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = backgroundImageView.bounds
    }
    
    func configureDetails() {
        if let photoUrl = URL(string: viewModel.fighter.photo ?? "") {
            fighterImageView.kf.setImage(with: photoUrl)
        }
        nameLabel.text = "Name: \(viewModel.fighter.name ?? "N/A")"
        nicknameLabel.text = "Nickname: \(viewModel.fighter.nickname ?? "N/A")"
        ageLabel.text = "Age: \(viewModel.fighter.age != nil ? "\(viewModel.fighter.age!)" : "N/A")"
        
        if let heightString = viewModel.fighter.height, let heightInches = heightString.heightStringToInches() {
            let heightCm = heightInches.inchesToCentimeters()
            heightLabel.text = "Height: \(heightString) / \(String(format: "%.2f", heightCm)) cm"
        } else {
            heightLabel.text = "Height: N/A"
        }
        
        if let weightString = viewModel.fighter.weight, let weightLbs = Double(weightString.replacingOccurrences(of: " lbs", with: "")) {
            let weightKg = weightLbs.poundsToKilograms()
            weightLabel.text = "Weight: \(weightLbs) lbs / \(String(format: "%.2f", weightKg)) kg"
        } else {
            weightLabel.text = "Weight: N/A"
        }
        
        if let reachString = viewModel.fighter.reach, let reachInches = Double(reachString.replacingOccurrences(of: "'", with: "")) {
            let reachCm = reachInches.inchesToCentimeters()
            reachLabel.text = "Reach: \(reachString) / \(String(format: "%.2f", reachCm)) cm"
        } else {
            reachLabel.text = "Reach: N/A"
        }
        
        stanceLabel.text = "Stance: \(viewModel.fighter.stance ?? "N/A")"
        teamLabel.text = "Team: \(viewModel.fighter.team?.name ?? "N/A")"
        categoryLabel.text = "Category: \(viewModel.fighter.category ?? "N/A")"
    }
    
    func bindViewModel() {
        viewModel.$fighter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.configureDetails()
            }
            .store(in: &disposables)
    }
}
