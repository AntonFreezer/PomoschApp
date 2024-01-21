//
//  WardDetailsVM.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 20.01.2024.
//

import UIKit
import PomoschAPI

final class WardDetailsVM {
    //MARK: Properties
    private let wardId: ID
    private var ward: ModelTypes.WardDetailsModule.Ward?
    
    public var onWardSetup: (() -> Void)?
    
    public var wardName: String {
        ward?.publicInformation.name.displayName ?? ""
    }
    
    public var wardStatus: String {
        ward?.immediateHelpRequired ?? false ? "Needs immediate help" : "No urgent needs at the moment"
    }
    
    private var imageURL: URL? {
        URL(string: ward?.publicInformation.photo.url ?? "")
    }
    
    enum SectionType {
        case info(viewModel: WardInfoCellViewModel)
    }
    
    public var sections: [SectionType] = []
    
    //MARK: - Lifecycle & Setup
    
    init(wardId: ID) {
        self.wardId = wardId
        
        fetchWard(by: self.wardId) { [weak self] in
            self?.setupSections()
            self?.onWardSetup?()
        }
    }

    
    private func setupSections() {
        sections = [
            .info(viewModel: .init(ward: ward)),
        ]
    }
    
    //MARK: - Network
    private func fetchWard(by id: ID, completion: @escaping () -> Void) {
        
        PomoschGqlService.shared.apollo.fetch(query: WardByIdQuery(id: id)) { result in
            switch result {
            case .success(let graphQLResult):
                self.ward = graphQLResult.data?.wardById
                
            case .failure(let error):
                print(String(describing: error))
            }
            
            completion()
        }
    }
    
    public func fetchImage(completion: @escaping (Result<URL,Error>) -> Void) {
        guard let imageURL = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        completion(.success(imageURL))
    }
    
    //MARK: - CollectionView Layouts
    
    private func createDefaultLayoutItem() -> NSCollectionLayoutItem {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 0.5, bottom: 10, trailing: 0.5)
        return item
    }
    
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),                                                      heightDimension: .absolute(25.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        return header
    }
    
    public func createInfoSectionLayout()  -> NSCollectionLayoutSection {
        let item = createDefaultLayoutItem()
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(124)),
            subitems: [item, item]
        )
        
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    public func createOriginSectionLayout() -> NSCollectionLayoutSection {
        let item = createDefaultLayoutItem()
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100)),
            subitems: [item]
        )
        
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        return section
        
    }
    
    public func createEpisodeSectionLayout()  -> NSCollectionLayoutSection {
        let item = createDefaultLayoutItem()
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 0.5, bottom: 0, trailing: 0.5)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(86)
            ), subitems: [item]
        )
        let header = createHeader()
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [header]
        section.orthogonalScrollingBehavior = .none
        return section
    }
}

