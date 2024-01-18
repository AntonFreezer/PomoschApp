//
//  UIImage+.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit

extension UIImage {
    func downsampleImage(for size: CGSize) -> UIImage? {
        var aspectFillSize = size

        let newWidth: CGFloat = size.width / self.size.width
        let newHeight: CGFloat = size.height / self.size.height

        if newHeight > newWidth {
            aspectFillSize.width = newHeight * self.size.width
        } else if newHeight < newWidth {
            aspectFillSize.height = newWidth * self.size.height
        }

        let renderer = UIGraphicsImageRenderer(size: aspectFillSize)

        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: aspectFillSize))
        }
    }
}
