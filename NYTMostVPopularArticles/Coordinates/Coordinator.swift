//
//  Coordinator.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/7/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
