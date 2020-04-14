//
//  ArenaRouter.swift
//  Movies
//
//  Created by ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//
import UIKit.UIApplication

typealias ArenaPresenter = UIViewController

protocol Route { }

protocol Router {
    associatedtype Route
    var arenaPresenter: ArenaPresenter { get set }
    func route(to route: Route)
}

extension Router {
    
    func launch(arena: Arena, window: UIWindow? = nil) {
        guard let windowToLaunchOn = window ?? UIApplication.shared.windows.first else {
            print("Couldn't launch arena")
            return
        }
        
        arena.launch(window: windowToLaunchOn)
    }
    
    func present(arena: Arena) {
        guard let viewController = arena.viewController else { return }
//        viewController.modalPresentationStyle = .fullScreen
        self.arenaPresenter.present(viewController, animated: true, completion: nil)
    }
    
    func presentInsideNavigationController(arena: Arena) {
        guard let viewController = arena.viewController else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
        self.arenaPresenter.present(navigationController, animated: true, completion: nil)
    }
    
    func push(arena: Arena) {
        guard let viewController = arena.viewController else { return }
        self.arenaPresenter.navigationController?.pushViewController(viewController, animated: true)
    }
}
