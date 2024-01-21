//
//  ManifestView.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 21.01.2024.
//

import UIKit

final class ManifestView: UIView {
    
    //MARK: UI Components
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.image = UIImage(named: "LogoAsText")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let manifestTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        
        textView.showsVerticalScrollIndicator = false
        textView.text = R.ManifestModule.manifestText
        textView.textAlignment = .justified
        textView.font = .systemFont(ofSize: 24, weight: .ultraLight)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    //MARK: Lifecycle & Setup
    
    init() {
        super.init(frame: .zero)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(logoImageView)
        self.addSubview(manifestTextView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            logoImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            logoImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            
            manifestTextView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            manifestTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            manifestTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            manifestTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }

}
