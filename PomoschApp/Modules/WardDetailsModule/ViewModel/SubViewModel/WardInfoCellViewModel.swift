//
//  WardInfoCellViewModel.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 20.01.2024.
//

import UIKit

final class WardInfoCellViewModel {
    
    //MARK: Properties
    
    private let ward: ModelTypes.WardDetailsModule.Ward?
    
    let city: String
    let oneTimeNeeds: String
    let regularNeeds: String
    
    //MARK: Lifecycle & Setup
    
    init(ward: ModelTypes.WardDetailsModule.Ward?) {
        self.ward = ward
        
        self.city = ward?.publicInformation.city ?? ""
        self.oneTimeNeeds = String(ward?.amounts.oneTimeNeeds.totalRequiredAmount ?? 0)
        self.regularNeeds = String(ward?.amounts.regularNeeds.totalRequiredAmount ?? 0)
    }
}

