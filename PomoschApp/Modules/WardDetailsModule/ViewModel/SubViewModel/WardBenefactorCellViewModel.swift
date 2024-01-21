//
//  WardBenefactorCellViewModel.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 21.01.2024.
//

import UIKit

final class WardBenefactorCellViewModel {
    
    //MARK: Properties
    
    private let benefactor: ModelTypes.WardDetailsModule.Benefactor?
    
    let id: String
    let amountSpent: String
    let displayName: String
    let benefactorImageUrl: String?
    
    //MARK: Lifecycle & Setup
    
    init(benefactor: ModelTypes.WardDetailsModule.Benefactor?) {
        self.benefactor = benefactor
        
        self.id = benefactor?.benefactor.id ?? ""
        self.amountSpent = String(benefactor?.amountSpent ?? 0)
        self.displayName = benefactor?.benefactor.displayName ?? ""
        self.benefactorImageUrl = benefactor?.benefactor.photo?.url
    }
    
}
//MARK: - Network

extension WardBenefactorCellViewModel {
    
    public func fetchImage(completion: @escaping (Result<URL, Error>) -> Void) {
        guard let url = benefactorImageUrl, let convertedURL = URL(string: url) else {
            return
        }
        
        completion(.success(convertedURL))
    }
    
}
