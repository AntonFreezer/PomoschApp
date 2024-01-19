//
//  WardCellViewModel.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import Foundation

class WardCellViewModel {
    //MARK: - Properties
    let wardDisplayName: String
    let wardImageUrl: URL?
    
    //MARK: - Lifecycle
    
    init(wardDisplayName: String, wardImageUrl: URL?) {
        self.wardDisplayName = wardDisplayName
        self.wardImageUrl = wardImageUrl
    }
    
    //MARK: - Network
    
    public func fetchImage(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = wardImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        completion(.success(url))
    }
}

//MARK: - Hashable & Equatable

extension WardCellViewModel: Hashable, Equatable {
    static func == (lhs: WardCellViewModel, rhs: WardCellViewModel) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(wardDisplayName)
        hasher.combine(wardImageUrl)
    }
    
}
