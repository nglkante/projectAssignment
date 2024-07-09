import Foundation
import Combine

class FightersByWeightClassVM {
    @Published var fighters: [FighterResponse] = []
    @Published var filteredFighters: [FighterResponse] = []
    @Published var error: Error?

    var networkService: NetworkService
    var disposables = Set<AnyCancellable>()
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
        setupBindings()
    }
    
    func setupBindings() {
        $fighters
            .sink { [weak self] fighters in
                self?.filteredFighters = fighters
            }
            .store(in: &disposables)
    }
    
    func fetchFighters(weightClass: String) {
        networkService.fetchFighters(weightClass: weightClass) { [weak self] (result: Result<[FighterResponse], Error>) in
            switch result {
            case .success(let fighters):
                DispatchQueue.main.async {
                    self?.fighters = fighters
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error
                }
            }
        }
    }
    
    func filterFighters(by name: String) {
        guard !name.isEmpty else {
            filteredFighters = fighters
            return
        }
        filteredFighters = fighters.filter { $0.name?.lowercased().contains(name.lowercased()) == true }
    }
}
