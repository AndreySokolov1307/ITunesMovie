//
//  ViewController.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit
import Combine

fileprivate enum Section: CaseIterable {
    case main
}

class MovieSearchViewController: UIViewController {
    
    private lazy var movieView = MovieView()
    private let viewModel = MovieSearchViewModel()
    private let searchController = UISearchController()
    private var subscriptions: Set<AnyCancellable> = []
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, MovieCellViewModel>!
    private var moviesSnapshot: NSDiffableDataSourceSnapshot<Section, MovieCellViewModel> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MovieCellViewModel>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.movieViewModels)
        
        return snapshot
    }
    
    override func loadView() {
        view = movieView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        cellRegistration()
        createDataSource()
        bind()
    }
    
    private func setupNavBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.automaticallyShowsSearchResultsController = true
    }
    
    private func bind() {
        viewModel.$movieViewModels
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] viewModels in
                // applySnapshot

                self?.dataSource.apply(self!.moviesSnapshot)
            })
            .store(in: &subscriptions)
    }
    
    private func cellRegistration() {
        movieView.collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
    }
    
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, MovieCellViewModel>(collectionView: movieView.collectionView, cellProvider: { (collectionView, indexPath, item) -> MovieCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            
            cell.viewModel = self.viewModel.movieViewModels[indexPath.row]
            return cell
        })
        dataSource.apply(moviesSnapshot)
    }
}

//MARK: - UISearchResultsUpdating

extension MovieSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text,
              !text.isEmpty else { return }
        viewModel.searchText = text
    }
}
