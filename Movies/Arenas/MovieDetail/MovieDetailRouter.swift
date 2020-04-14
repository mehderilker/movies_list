import Foundation

enum MovieDetailRoute: Route {
    case backHomePage
}

final class MovieDetailRouter: Router {
    typealias ArenaRoute = MovieDetailRoute
    
    var arenaPresenter: ArenaPresenter
    
    init(arenaPresenter: ArenaPresenter) {
        self.arenaPresenter = arenaPresenter
    }
    
    func route(to route: MovieDetailRoute) {
        switch route {
        case .backHomePage:
            let homePageVC = ArenaType.homePage
            self.launch(arena: homePageVC)
        default:
            print("No route")
        }
    }
}
