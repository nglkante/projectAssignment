import Foundation
import Combine

class WeightClassViewModel {
    @Published var categories: [String] = []
    @Published var error: Error?

    var networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchCategories() {
        networkService.fetchCategories { [weak self] (result: Result<[String], Error>) in
            switch result {
            case .success(let categories):
                DispatchQueue.main.async {
                    self?.categories = categories
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                }
            }
        }
    }
}
