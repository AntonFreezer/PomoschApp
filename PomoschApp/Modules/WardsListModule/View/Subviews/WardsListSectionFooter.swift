//
//  WardsListSectionFooter.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 19.01.2024.
//

import Foundation
import UIKit

final class WardsListSectionFooter: UICollectionReusableView {
    static let identifier = "WardListSectionFooter"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        
        spinner.color = .darkGray
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFooterView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupFooterView() {
        backgroundColor = .white
        addSubview(spinner)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 75),
            spinner.heightAnchor.constraint(equalToConstant: 75),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func startAnimating() {
        spinner.startAnimating()
    }
}
