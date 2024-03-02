//
//  Movie.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import Foundation

struct SearchResponce: Codable {
    let results: [Movie]
}

struct Movie: Codable, Hashable {
    let name: String
    let artist: String
    var kind: String
    var description: String
    var artworkURL: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind
        case description = "longDescription"
        case artworkURL = "artworkUrl100"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case description = "shortDescription"
        case collectionName = "collectionName"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.artist = try container.decode(String.self, forKey: .artist)
        self.kind = (try? container.decode(String.self, forKey: .kind)) ?? ""
        self.artworkURL = try container.decode(URL.self, forKey: .artworkURL)
        
        let additionalContainer = try decoder.container(keyedBy: AdditionalKeys.self)
        
        self.name = (try? container.decode(String.self, forKey: .name)) ?? (try? additionalContainer.decode(String.self, forKey: .collectionName)) ?? "--"
        self.description = (try? container.decode(String.self, forKey: .description)) ?? (try? additionalContainer.decode(String.self, forKey: .description)) ?? "--"
    }
}
