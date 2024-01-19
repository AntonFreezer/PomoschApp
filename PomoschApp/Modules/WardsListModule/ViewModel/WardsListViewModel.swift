//
//  WardsListViewModel.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit
import Foundation
import PomoschAPI

protocol WardsListViewModelDelegate: AnyObject {
    func didFetchWards()
    func didSelectWard(_ ward: ModelTypes.Ward)
}

final class WardsListViewModel: NSObject {
    
    //MARK: Properties
    
    public weak var delegate: WardsListViewModelDelegate?
    
    private var wards: [ModelTypes.Ward] = [] {
        didSet {
            for ward in wards {
                let viewModel = WardCellViewModel(
                    wardDisplayName: ward.node.publicInformation.name.displayName,
                    wardImageUrl: URL(string: ward.node.publicInformation.photo.url)
                )
                
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModels: [WardCellViewModel] = []
    
    private var currentPageInfo: ModelTypes.PageInfo?
    
    //MARK: Network
    public func fetchWardsIfExist() {
        guard let currentPageInfo else {
            self.fetchWards(from: nil)
            return
        }
        
        guard currentPageInfo.hasNextPage else {
            return
        }
        
        self.fetchWards(from: currentPageInfo.endCursor)
    }
    
    private func fetchWards(from cursor: String?) {
        PomoschGqlService.shared.apollo.fetch(query: WardsPaginatedQuery(cursorAfter: cursor ?? nil)) { [weak self] result in
            // guard let strongSelf = self else { return }
            
            self?.currentPageInfo = nil
            
            switch result {
                
            case.success(let graphQLResult):
                if let wards = graphQLResult.data?.wards {
                    self?.currentPageInfo = wards.pageInfo
                    self?.wards.append(contentsOf: wards.edges?.compactMap{ $0 } ?? [])
                    
                    DispatchQueue.main.async {
                        self?.delegate?.didFetchWards()
                    }
                }
                
                if let errors = graphQLResult.errors {
                    print(String(describing: errors))
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

//MARK: - CollectionView DataSource&Delegate

extension WardsListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WardViewCell.cellIdentifier, for: indexPath) as? WardViewCell else {
            fatalError("Could not create cell for \(indexPath.item)")
        }
        
        let viewModel = cellViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        
        let width = (bounds.width-25) / 2
        let height = width * 1.35
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ward = wards[indexPath.row]
        delegate?.didSelectWard(ward)
    }
}

//MARK: - ScrollView Delegate & Pagination

extension WardsListViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard !cellViewModels.isEmpty else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
                self?.fetchWardsIfExist()
            }
            t.invalidate()
        }
    }
}
