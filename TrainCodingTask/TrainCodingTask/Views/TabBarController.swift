//
//  TabBarController.swift
//  TrainCodingTask
//
//  Created by Kalin Spassov on 28/11/2022.
//

import UIKit

enum TabBarItems: CaseIterable {
    case explore
    case stats
    
    static var showBadge: Bool = false
    static var allCases: [TabBarItems] = [.explore, .stats]
    
    var title: String {
        switch self {
        case .explore: return "Routes"
        case .stats: return "Stops"
        }
    }
    
    var image: UIImage {
        switch self {
        case .explore: return UIImage(systemName: "lasso")!
        case .stats: return UIImage(systemName: "pencil.tip")!
        }
    }
    
    var value: Int {
        switch self {
        case .explore: return 0
        case .stats: return 1
        
        }
    }
    
    var selectedImage: UIImage? {
        return nil
    }
}

final class TabBarController: UITabBarController {
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .clear
        viewControllers = getTabBarNavigationControllers()
        
        ApiManager.getRoutesData(completion: {
            NotificationCenter.default.post(name: EventNotifications.dataLoaded.name, object: nil)
        })
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Private Methods
private extension TabBarController {
    func getTabBarNavigationControllers() -> [UINavigationController] {
        let viewControllers: [UIViewController] = [getExploreVC(), getStatsVC()]
        zip(viewControllers, getTabBarItems()).forEach({$0.0.tabBarItem = $0.1 })
        return viewControllers.compactMap({
            let nav = UINavigationController(rootViewController: $0)
            return nav
        })
    }
    
    func getTabBarItems() -> [UITabBarItem] {
        return TabBarItems.allCases.compactMap({
            let item  = UITabBarItem(title: $0.title, image: $0.image, selectedImage: $0.selectedImage)
            return item
        })
    }
    
    func getExploreVC() -> RoutesVC {
        return RoutesVC()

    }
    
    func getStatsVC() -> StopsVC {
        return StopsVC()
    }
}
