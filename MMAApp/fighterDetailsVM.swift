import Foundation
import Combine

class FighterDetailsViewModel: ObservableObject {
    @Published var fighter: FighterResponse
    
    init(fighter: FighterResponse) {
        self.fighter = fighter
    }
}

