//
//  MovieCellViewModel.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit
import Combine

final class MovieCellViewModel {
    @Published var movieName: String = ""
    @Published var description: String = ""
    @Published var image: UIImage?
    
    private var imageSubscription: AnyCancellable?
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        movieName = movie.name
        description = movie.description
    }
    
    func getImage() {
      imageSubscription =  MovieService.shared.getImage(withURL: movie.artworkURL)
            .sink(receiveValue: { [weak self] image in
                self?.image = image
            })
    }
}

extension MovieCellViewModel: Hashable {
    static func == (lhs: MovieCellViewModel, rhs: MovieCellViewModel) -> Bool {
        lhs.movieName == rhs.movieName && lhs.description == rhs.description
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movieName)
        hasher.combine(description)
    }
}
