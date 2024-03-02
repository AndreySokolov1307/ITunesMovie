//
//  NetworkService.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit
import Combine

enum ServiceError: Error {
    case invalidURL
    case invalidStatusCode
}

protocol IMovieService {
    func getMovies(with searchTerm: String) -> AnyPublisher<[Movie], Error>
}

final class MovieService: IMovieService {
   
    static let shared = MovieService()
    
    private let baseURL = Constants.network.baseURL
    
    private func absoluteURL(movie: String) -> URL? {
        let components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        guard var urlComponents = components else { return nil }
        var query = Constants.network.query
        query[Constants.network.queryTerm] = movie
        
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value) }
        return urlComponents.url
    }
    
    func getMovies(with searchTerm: String) -> AnyPublisher<[Movie], Error> {
        guard let url = absoluteURL(movie: searchTerm) else {
            return Fail(error: ServiceError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, responce) in
                guard let responce = responce as? HTTPURLResponse,
                      responce.statusCode == 200 else {
                    throw ServiceError.invalidStatusCode
                }
                return data
            }
            .decode(type: SearchResponce.self, decoder: JSONDecoder())
            .map { $0.results }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getImage(withURL url: URL) -> AnyPublisher<UIImage, Never> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map {
                guard let image = UIImage(data: $0.data) else {
                    return Constants.images.default
                }
                
                return image
            }
            .receive(on: RunLoop.main)
            .replaceError(with: Constants.images.default)
            .eraseToAnyPublisher()
    }
}
