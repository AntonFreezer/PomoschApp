//
//  WardViewCell.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit
import Kingfisher

final class WardViewCell: UICollectionViewCell {
    static let cellIdentifier = "WardViewCell"
    
    //MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let displayNameLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - Lifecycle & Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCell()
        setupLayer()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.backgroundColor = .systemGray4
        contentView.addSubview(imageView)
        contentView.addSubview(displayNameLabel)
    }
    
    private func setupLayer() {
        // contentView
        contentView.layer.cornerRadius = contentView.bounds.height / 12
        
        // imageView
        imageView.layer.cornerRadius = (contentView.bounds.height / 12) - 5
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // nameLabel
            displayNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            displayNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            displayNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // imageView
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: displayNameLabel.topAnchor, constant: -20)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
        self.displayNameLabel.text = nil
    }
}
//MARK: - ViewModel

extension WardViewCell {
    public func configure(with viewModel: WardCellViewModel) {
        // Text
        displayNameLabel.text = viewModel.wardDisplayName
        // Image
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .success(let url):
                ImageManager.shared.setImage(at: url, for: self?.imageView, cornerRadius: 16)
                
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
    
}

