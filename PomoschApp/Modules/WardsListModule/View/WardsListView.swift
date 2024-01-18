//
//  WardsListView.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit
import PomoschAPI

protocol WardsListViewDelegate: AnyObject {
    func wardsListView(
        _ characterListView: WardsListView,
        didSelectWard ward: ModelTypes.Ward
    )
}

final class WardsListView: UIView {
    //MARK: - Properties
    
    public weak var delegate: WardsListViewDelegate?
    private let viewModel = WardsListViewModel()
    
    //MARK: - UI Components
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        let topInset: CGFloat = 50
        collectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        
        collectionView.backgroundColor = .clear
        collectionView.register(WardViewCell.self, forCellWithReuseIdentifier: WardViewCell.cellIdentifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    //MARK: - Lifecycle & Setup
    
    init() {
        super.init(frame: .zero)
        
        addSubview(collectionView)
        
        setupLayout()
        setupViewModel()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.fetchWards()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
    }
}

    //MARK: - WardsListViewModel Delegate
    
extension WardsListView: WardsListViewModelDelegate {
    func didFetchWards() {
        collectionView.reloadData()
        // animation
    }

    func didSelectWard(_ ward: ModelTypes.Ward) {
        delegate?.wardsListView(self, didSelectWard: ward)
    }
}

