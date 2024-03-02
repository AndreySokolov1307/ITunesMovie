//
//  MovieCell.swift
//  ITunesMovies
//
//  Created by Андрей Соколов on 01.03.2024.
//

import UIKit
import Combine

final class MovieCell: UICollectionViewCell {
    static let reuseIdentifier = Constants.strings.movieCellReuseIdentifier
    private var subscription: AnyCancellable?
    
    var viewModel: MovieCellViewModel! {
        didSet {
            titleLabel.text = viewModel.movieName
            detailLabel.text = viewModel.description
            viewModel.getImage()
            subscription =  viewModel.$image
                .sink { image in
                    self.imageView.image = image
                }
        }
    }
    
   @UseAutolayout private var vStack: UIStackView = .style {
        $0.axis = .vertical
        $0.spacing = 4
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    let imageView: UIImageView = .style {
        $0.contentMode = .scaleAspectFit
    }
    
    let titleLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.numberOfLines = 1
        $0.contentMode = .left
    }
    
    let detailLabel: UILabel = .style {
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.numberOfLines = 1
        $0.contentMode = .left
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCell() {
        addSubview(vStack)
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(detailLabel)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            vStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            vStack.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
}
