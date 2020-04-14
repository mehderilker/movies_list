import Foundation

enum HomePageRoute: Route {
    case movieDetail(movieId: Int)
}

final class HomePageRouter: Router {
    typealias ArenaRoute = HomePageRoute
    
    var arenaPresenter: ArenaPresenter
    
    init(arenaPresenter: ArenaPresenter) {
        self.arenaPresenter = arenaPresenter
    }
    
    func route(to route: HomePageRoute) {
        switch route {
        case let .movieDetail(movieId):
            let movieDetailVC = ArenaType.movieDetail(movieId: movieId)
            self.launch(arena: movieDetailVC)
            
        default:
            print("No route")
        }
    }
}
