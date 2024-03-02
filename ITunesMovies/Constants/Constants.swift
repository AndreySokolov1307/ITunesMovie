//
//  UIConstants.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit

enum Constants {
    enum layout {
        static let itemSizeWidth: CGFloat = 1/3
        static let itemSizeHeight: CGFloat = 1
        static let groupSizeWidth: CGFloat = 1
        static let groupSizeHeight: CGFloat = 0.5
        static let groupItemsCount = 3
        static let interGoupSpacing: CGFloat = 8
        static let sectionContentInsets = NSDirectionalEdgeInsets(top: 8,
                                                                  leading: 8,
                                                                  bottom: 8,
                                                                  trailing: 8
        )
        static let itemContentInsets = NSDirectionalEdgeInsets(top: 8,
                                                               leading: 5,
                                                               bottom: 8,
                                                               trailing: 5)
    }
    
    enum strings {
        static let movieCellReuseIdentifier = "MovieCell"
    }
    
    enum network {
        static let baseURL = URL(string: "https://itunes.apple.com/search")!
        static let query = [
            "media": "movie",
            "lang": "en_us",
            "limit": "20"
        ]
        static let queryTerm = "term"
    }
    
    enum images {
        static let `default` = UIImage(systemName: "photo")!
    }
}
