//
//  WardInfoCollectionViewCell.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 20.01.2024.
//

import UIKit

final class WardInfoCollectionViewCell: UICollectionViewCell {
    
    //MARK: Properties
    
    static let cellIdentifier = "WardInfoCollectionViewCell"
    
    //MARK: UI Components
    
    private var cityLabel: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.leadingText = "Lives in:"
        label.leadingTextColor = .black.withAlphaComponent(0.7)
        label.trailingTextColor = .black
        
        return label
    }()
    
    private var oneTimeNeeds: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium )
        label.leadingText = "One time needs:"
        label.leadingTextColor = .black.withAlphaComponent(0.7)
        label.trailingTextColor = .black
        return label
    }()
    
    private var regularNeeds: DualLabelView = {
        let label = DualLabelView(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.leadingText = "Regular needs:"
        label.leadingTextColor = .black.withAlphaComponent(0.7)
        label.trailingTextColor = .black
        
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        return stackView
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
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(oneTimeNeeds)
        stackView.addArrangedSubview(regularNeeds)
        
        contentView.addSubview(stackView)
    }
    
    private func setupLayer() {
        contentView.layer.cornerRadius = contentView.bounds.height / 10
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cityLabel.trailingText = nil
        oneTimeNeeds.trailingText = nil
        regularNeeds.trailingText = nil
    }
    
}
//MARK: - ViewModel

extension WardInfoCollectionViewCell {
    
    public func configure(with viewModel: WardInfoCellViewModel) {
        cityLabel.trailingText = viewModel.city
        oneTimeNeeds.trailingText = viewModel.oneTimeNeeds
        regularNeeds.trailingText = viewModel.regularNeeds
    }

}
