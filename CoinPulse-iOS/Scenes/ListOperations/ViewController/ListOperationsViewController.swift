//
//  ListOperationsViewController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import UIKit

final class ListOperationsViewController: ListOperations.DisplayLogic {
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    
    var interactor: ListOperations.BusinessLogic?
    
    private var dataSource: UICollectionViewDiffableDataSource<ListOperations.Sections, Int>!
    private var snapshot: NSDiffableDataSourceSnapshot<ListOperations.Sections, Int>!
    
    private var sections = DynamicSections<ListOperations.Sections>()
    
    override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupReusableView() {
        super.setupReusableView()
        collectionView.registerCell(ListOperationsCategoryCell.self)
        collectionView.registerHeader(LargeHeaderReusableView.self)
    }
    
    override func setupDataSource() {
        super.setupDataSource()
        
        // FIXME: Править
        sections.appendSection(.categories)
        
        dataSource = UICollectionViewDiffableDataSource<ListOperations.Sections, Int>(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                case .categories:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsCategoryCell
                    cell.configureCell(with: "Hello")
                    return cell
                case .unknown:
                    return BaseCollectionViewCell()
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                    case .categories:
                        let header = collectionView.dequeueHeader(for: indexPath) as LargeHeaderReusableView
                        header.configureView(
                            with: "Categories",
                            titleButton: "View all",
                            delegate: self
                        )
                        return nil
                        
                    case .unknown:
                        return BaseCollectionReusableView()
                }
            }
            
            return BaseCollectionReusableView()
        }
    }
    
    override func setupInitialSnapshot() {
        super.setupInitialSnapshot()
        
        snapshot = NSDiffableDataSourceSnapshot<ListOperations.Sections, Int>()
        snapshot.appendSections([.categories])
        snapshot.appendItems([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], toSection: .categories)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

private extension ListOperations.ViewController {
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.sections.getSection(by: section) ?? .unknown {
                case .categories:
                    ListOperationsCategoryCellLayout.layout()
                case .unknown:
                    ListOperationsCategoryCellLayout.layout()
            }
        }
    }
}

extension ListOperations.ViewController: LargeHeaderReusableViewDelegate {
    func actionButtonDidTapped() {
        // Tap
    }
}
