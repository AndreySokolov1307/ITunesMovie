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
    
    @UseAutolayout var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.contentMode = .left
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.numberOfLines = 1
        label.contentMode = .left
        return label
    }()
    
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
