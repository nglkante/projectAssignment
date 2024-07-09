import UIKit

class Router{
    
    let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(in window: UIWindow) {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        showWeightClasses()
    }
    func showWeightClasses() {
        let weightClassViewModel = WeightClassViewModel(networkService: NetworkService())
        let vc = WeightClassViewController(viewModel: weightClassViewModel, router: self)
        navigationController.setViewControllers([vc], animated: false)
    }
    
    func showFighters(category: String){
        let fightersByClassViewModel = FightersByWeightClassVM(networkService: NetworkService())
        let vc = FightersByWeightClassVC(viewModel: fightersByClassViewModel, router: self)
        fightersByClassViewModel.fetchFighters(weightClass: category)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showFighterDetails(fighter: FighterResponse) {
         let viewModel = FighterDetailsViewModel(fighter: fighter)
         let vc = FighterDetailsViewController(viewModel: viewModel)
         navigationController.pushViewController(vc, animated: true)
     }
    
    func didSelectCategory(_ category: String) {
        showFighters(category: category)
    }
}
