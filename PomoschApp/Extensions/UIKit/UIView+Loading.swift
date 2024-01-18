//
//  UIView+.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit

extension UIView {
    static let loadingViewTag = 9999
    
    func showLoading(style: UIActivityIndicatorView.Style = .medium, color: UIColor? = nil) {
        var loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        
        if loading == nil {
            loading = UIActivityIndicatorView(style: .medium)
        }
        
        if let color = color {
            loading?.color = color
        }
        
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading?.startAnimating()
        loading?.hidesWhenStopped = true
        
        loading?.tag = UIView.loadingViewTag
        
        self.addSubview(loading!)
        
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
