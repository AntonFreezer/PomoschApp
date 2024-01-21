//
//  WardsListVC.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit

class WardsListVC: GenericViewController<WardsListView> {
    
    //MARK: Lifecycle & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Wards"
        rootView.backgroundColor = .white
        setupView()
    }
    
    private func setupView() {
        rootView.delegate = self
    }
    
}

//MARK: - WardsListView Delegate

extension WardsListVC: WardsListViewDelegate {
    func wardsListView(_ wardsListView: WardsListView, didSelectWard ward: ModelTypes.WardListModule.Ward) {
        
        let viewModel = WardDetailsVM(wardId: ward.node.id)
        let wardDetailsVC = WardDetailsVC(viewModel: viewModel)
        
        navigationController?.pushViewController(wardDetailsVC, animated: true)
    }
}
