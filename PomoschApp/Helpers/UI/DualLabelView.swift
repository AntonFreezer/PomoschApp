//
//  DualLabelView.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 20.01.2024.
//

import UIKit

class DualLabelView: UIView {
    
    private let leadingLabel = UILabel()
    private let trailingLabel = UILabel()

    // Shared properties
    public var font: UIFont = .systemFont(ofSize: UIFont.systemFontSize) {
        didSet {
            leadingLabel.font = font
            trailingLabel.font = font
        }
    }

    // Individual properties for leading label
    public var leadingText: String? {
        get { return leadingLabel.text }
        set { leadingLabel.text = newValue }
    }
    
    public var leadingFont: UIFont? {
        get { return leadingLabel.font }
        set { leadingLabel.font = newValue }
    }

    // Individual properties for trailing label
    public var trailingText: String? {
        get { return trailingLabel.text }
        set { trailingLabel.text = newValue }
    }
    
    public var trailingFont: UIFont? {
        get { return trailingLabel.font }
        set { trailingLabel.font = newValue }
    }
    
    public var leadingTextColor: UIColor? {
        get { return leadingLabel.textColor }
        set { leadingLabel.textColor = newValue }
    }
    
    public var trailingTextColor: UIColor? {
        get { return trailingLabel.textColor }
        set { trailingLabel.textColor = newValue }
    }
    
    /// Initialize and set up subviews and constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        addSubview(leadingLabel)
        addSubview(trailingLabel)
        
        leadingLabel.textAlignment = .left
        trailingLabel.textAlignment = .right
    }
    
    private func setupConstraints() {
        leadingLabel.translatesAutoresizingMaskIntoConstraints = false
        trailingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leadingLabel.topAnchor.constraint(equalTo: topAnchor),
            leadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            trailingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            trailingLabel.topAnchor.constraint(equalTo: topAnchor),
            trailingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingLabel.leadingAnchor.constraint(equalTo: leadingLabel.trailingAnchor),
        ])
    }
}

