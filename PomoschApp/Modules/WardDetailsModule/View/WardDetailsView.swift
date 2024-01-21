//
//  WardDetailsView.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 20.01.2024.
//

import Foundation
import UIKit

class WardDetailsView: UIView {
    //MARK: - Properties
    
    private var viewModel: WardDetailsVM?
    
    //MARK: - UI Components
    
    private let wardImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let wardNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private let wardStatusLabel: UILabel = {
        let label = UILabel(frame: .zero)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    public var collectionView: UICollectionView?
    
    //MARK: - Lifecycle & Setup
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, viewModel: WardDetailsVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setupView()
        setupViewModel()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setupView() {
        backgroundColor = .white

        self.collectionView = createCollectionView()
        
        addSubview(wardImageView)
        addSubview(wardNameLabel)
        addSubview(wardStatusLabel)
        addSubview(collectionView!)
    }
    
    private func setupViewModel() {
        viewModel?.onWardSetup = { [weak self] in
            self?.populateUpperElements()
            self?.collectionView?.reloadData()
        }
    }
    
    private func setupLayout() {
        guard let collectionView = collectionView.self else {
            return
        }
        
        NSLayoutConstraint.activate([
            wardImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            wardImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            wardImageView.heightAnchor.constraint(equalToConstant: 200),
            wardImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 15),
            wardImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -15),
            
            wardNameLabel.topAnchor.constraint(equalTo: wardImageView.bottomAnchor, constant: 20),
            wardNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            wardNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            wardStatusLabel.topAnchor.constraint(equalTo: wardNameLabel.bottomAnchor, constant: 5),
            wardStatusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            wardStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: wardStatusLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -25),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func populateUpperElements() {
        wardNameLabel.text = viewModel?.wardName
        wardStatusLabel.text = viewModel?.wardStatus
        
        viewModel?.fetchImage { [weak self] result in
            switch result {
            case .failure(let error):
                print(String(describing: error))
                break
                
            case .success(let url):
                DispatchQueue.main.async {
                    ImageManager.shared.setImage(at: url, for: self?.wardImageView, cornerRadius: 60)
                }
            }
        }
    }
    
    //MARK: - CollectionView
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            return self?.createSection(for: sectionIndex)
        }
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        
        // cells
        collectionView.register(WardInfoCollectionViewCell.self, forCellWithReuseIdentifier: WardInfoCollectionViewCell.cellIdentifier)
        collectionView.register(WardBenefactorCollectionViewCell.self, forCellWithReuseIdentifier: WardBenefactorCollectionViewCell.cellIdentifier)
        
        // supplementary
        collectionView.register(WardDetailsSectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: WardDetailsSectionHeader.identifier)
        
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection? {
        let sectionTypes = viewModel?.sections
        
        switch sectionTypes![sectionIndex] {
        case .info:
            return viewModel?.createInfoSectionLayout()
        case .benefactors:
            return viewModel?.createBenefactorSectionLayout()
        }
    }
}
