//
//  ModelTypes.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import PomoschAPI

struct ModelTypes {
    //MARK: WardsList Module
    struct WardListModule {
        typealias Ward = WardsPaginatedQuery.Data.Wards.Edge
        typealias PageInfo = WardsPaginatedQuery.Data.Wards.PageInfo
    }
    
    //MARK: WardDetails Module
    struct WardDetailsModule {
        typealias Ward = WardByIdQuery.Data.WardById
    }
}
