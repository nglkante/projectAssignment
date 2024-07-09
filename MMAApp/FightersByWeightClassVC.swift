import UIKit
import Combine
import PureLayout

class FightersByWeightClassVC: UIViewController {
    
    var viewModel: FightersByWeightClassVM!
    let router: Router!
    var fightersCollectionView: UICollectionView!
    var searchBar: UISearchBar!
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    var disposables = Set<AnyCancellable>()
    let gold = UIColor(red: 255/255.0, green: 215/255.0, blue: 0/255.0, alpha: 1.0)
    
    init(viewModel: FightersByWeightClassVM, router: Router) {
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
    }
    
    func createViews(){
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search"
        view.addSubview(searchBar)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        fightersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(fightersCollectionView)
    }
    
    func styleViews(){
        searchBar.backgroundColor = .black
        fightersCollectionView.backgroundColor = .black
        fightersCollectionView.register(FightersCell.self, forCellWithReuseIdentifier: FightersCell.identifier)
        title = "Fighters"
    }
    
    func defineLayout(){
        searchBar.autoPinEdge(toSuperviewSafeArea: .top, withInset: 0)
        searchBar.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        searchBar.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        
        fightersCollectionView.autoPinEdge(.top, to: .bottom, of: searchBar, withOffset: 8)
        fightersCollectionView.autoPinEdge(toSuperviewEdge: .left, withInset: 8)
        fightersCollectionView.autoPinEdge(toSuperviewEdge: .right, withInset: 8)
        fightersCollectionView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 8)
        fightersCollectionView.dataSource = self
        fightersCollectionView.delegate = self
    }
    
    func bindViewModel(){
        viewModel.$filteredFighters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.fightersCollectionView.reloadData()
            }
            .store(in: &disposables)
    }
}

extension FightersByWeightClassVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredFighters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let fightersCell = collectionView.dequeueReusableCell(withReuseIdentifier: FightersCell.identifier, for: indexPath) as! FightersCell
        fightersCell.fighter = viewModel.filteredFighters[indexPath.row]
        return fightersCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedFighter = viewModel.filteredFighters[indexPath.row]
        router.showFighterDetails(fighter: selectedFighter)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 8, bottom: 24, right: 8)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterFighters(by: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
