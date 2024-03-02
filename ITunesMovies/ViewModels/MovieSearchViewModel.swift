//
//  MovieSearchViewModel.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import Foundation
import Combine

final class MovieSearchViewModel {
    @Published var searchText: String = ""
    @Published private(set) var movieViewModels: [MovieCellViewModel] = []
    
    private var subscriptions: Set<AnyCancellable> = []
    private var movieServiceSubscription: AnyCancellable?
    
    init() {
       $searchText
            .debounce(for: 1, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] in
           self?.fetchMovies(with: $0)
        })
       .store(in: &subscriptions)
 
    }
    
    func fetchMovies(with searchTerm: String) {
       movieServiceSubscription = MovieService.shared.getMovies(with: searchTerm)
            .sink { _ in
                
            } receiveValue: { [weak self] movies in
                self?.movieViewModels = movies.map { MovieCellViewModel(movie: $0) }
            }
    }
}
