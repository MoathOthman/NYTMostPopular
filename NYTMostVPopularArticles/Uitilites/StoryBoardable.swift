//
//  StoryBoardable.swift
//  NYTMostVPopularArticles
//
//  Created by Moath_Othman on 12/7/19.
//  Copyright © 2019 moath. All rights reserved.
//

import Foundation
import UIKit

protocol StoryBoardable {
    associatedtype ViewControllerType
    static func storyBoardInstance() -> UIStoryboard
    static func instantiatedView() -> ViewControllerType
}

extension  StoryBoardable {
    // swiftlint:disable force_cast
    static func instantiatedView() -> ViewControllerType {
        return storyBoardInstance().instantiateViewController(withIdentifier: "\(Self.self)") as! ViewControllerType
    }
    // swiftlint:enable force_cast
}
