//
//  WardBenefactorCollectionViewCell.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 21.01.2024.
//

import UIKit

final class WardBenefactorCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    static let cellIdentifier = "WardBenefactorCollectionViewCell"
    
    //MARK: UI Components
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        
        return imageView
    }()
    
    private var displayNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium )
        label.textColor = .black
        
        return label
    }()
    
    private var amountSpentLabel: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.leadingText = "Donated:"
        label.leadingTextColor = .black.withAlphaComponent(0.7)
        label.trailingTextColor = .black
        
        return label
    }()
    
    //MARK: Lifecycle & Setup
    
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
        contentView.backgroundColor = .systemGray6
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(displayNameLabel)
        contentView.addSubview(amountSpentLabel)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = contentView.bounds.height / 10
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            photoImageView.widthAnchor.constraint(equalToConstant: 64),
            
            displayNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            displayNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            displayNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            amountSpentLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 10),
            amountSpentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            amountSpentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        amountSpentLabel.trailingText = ""
    }
    
}

//MARK: - ViewModel

extension WardBenefactorCollectionViewCell {
    
    public func configure(with viewModel: WardBenefactorCellViewModel) {
        // text
        displayNameLabel.text = viewModel.displayName
        amountSpentLabel.trailingText = viewModel.amountSpent
        
        // photo
        viewModel.fetchImage { [weak self] result in
            switch result {
            case .failure(let error):
                print(String(describing: error))
            case .success(let url):
                ImageManager.shared.setImage(at: url, for: self?.photoImageView, cornerRadius: 20)
            }
        }
    }
    
}
