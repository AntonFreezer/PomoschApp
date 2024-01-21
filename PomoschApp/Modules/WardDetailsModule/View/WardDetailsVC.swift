//
//  WardDetailsVC.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit

final class WardDetailsVC: GenericViewController<WardDetailsView> {
    
    //MARK: Properties
    
    private let viewModel: WardDetailsVM
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: Lifecycle & Setup
    
    init(viewModel: WardDetailsVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = WardDetailsView(frame: .zero, viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.backgroundColor = .white
        
        configureNavigationBar()
        
        rootView.collectionView?.delegate = self
        rootView.collectionView?.dataSource = self
    }
    
    private func configureNavigationBar() {
        self.title = "Ward Details"
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
}

//MARK: - CollectionView DataSource & Delegate

extension WardDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: Section
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        
        switch sectionType {
        case .info:
            return 1
        case .benefactors(let viewModels):
            return viewModels.count
        }
    }
    
    //MARK: Cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .info(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WardInfoCollectionViewCell.cellIdentifier,
                for: indexPath) as? WardInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
            
        case .benefactors(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: WardBenefactorCollectionViewCell.cellIdentifier,
                for: indexPath) as? WardBenefactorCollectionViewCell else {
                fatalError()
            }
            
            let viewModel = viewModels[indexPath.item]
            
            cell.configure(with: viewModel)
            return cell
            
        }
        
        
    }
    
    //MARK: Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: WardDetailsSectionHeader.identifier,
            for: indexPath) as? WardDetailsSectionHeader
        else {
            fatalError("Could not dequeue footer view with \(WardDetailsSectionHeader.identifier)")
        }

        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .info:
            headerView.titleLabel.text = "Info"
            return headerView
        case .benefactors:
            headerView.titleLabel.text = "Who supports \(viewModel.wardName)"
            return headerView
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
}
