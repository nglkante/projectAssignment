import UIKit
import Combine
import PureLayout

class WeightClassViewController: UIViewController {
    
    var viewModel: WeightClassViewModel!
    let router: Router!
    var tableView: UITableView!
    var disposables = Set<AnyCancellable>()
    let gold = UIColor(red: 255/255.0, green: 215/255.0, blue: 0/255.0, alpha: 1.0)
    let backgroundImageView = UIImageView(image: UIImage(named: "oktagon"))

    weak var delegate: CategoriesViewControllerDelegate?
        
    init(viewModel: WeightClassViewModel, router: Router) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        styleViews()
        defineLayout()
        bindViewModel()
        navigationController?.setTitleColor(gold)
        viewModel.fetchCategories()
    }
    
    func createViews(){
        view.addSubview(backgroundImageView)
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
    }
    
    func styleViews(){
        view.backgroundColor = .clear
        tableView.backgroundColor = .clear
        tableView.rowHeight = 70
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        title = "MMA Weight Classes"
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func defineLayout(){
        backgroundImageView.autoPinEdgesToSuperviewSafeArea()
        tableView.autoPinEdgesToSuperviewSafeArea()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func bindViewModel(){
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &disposables)
    }
}

extension WeightClassViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        cell.backgroundColor = .clear
        let weightClass = viewModel.categories[indexPath.row]
        cell.set(weightClass: weightClass)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let selectedCategory = viewModel.categories[indexPath.row]
          router.showFighters(category: selectedCategory)
      }
}

protocol CategoriesViewControllerDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

