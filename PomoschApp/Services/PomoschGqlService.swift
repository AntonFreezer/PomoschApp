//
//  PomoschGqlService.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import Foundation
import Apollo

final class PomoschGqlService {
    static let shared = PomoschGqlService()
    
    private(set) var apollo = ApolloClient(url: R.URLs.pomoschGraphQlEndpoint)
    
    private init() { }
}
