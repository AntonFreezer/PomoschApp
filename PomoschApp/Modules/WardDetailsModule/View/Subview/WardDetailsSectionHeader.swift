//
//  WardDetailsSectionHeader.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 21.01.2024.
//

import UIKit

final class WardDetailsSectionHeader: UICollectionReusableView {
    
    //MARK: Properties
    
    static let identifier = "WardDetailsSectionHeader"
    
    //MARK: UI Components
    
    public let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    //MARK: Lifecycle & Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHeaderView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupHeaderView() {
        backgroundColor = .white
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
    }
}


