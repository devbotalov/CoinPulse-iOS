//
//  AllCategoriesViewController.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 15.10.2024.
//

import UIKit

final class AllCategoriesViewController: AllCategories.DisplayLogic {
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    
    var interactor: AllCategories.BusinessLogic?
    
    private var categories: [CategoryEntity] = []
    
    private var dataSource: UICollectionViewDiffableDataSource<AllCategories.Sections, ModelForSection>!
    private var snapshot: NSDiffableDataSourceSnapshot<AllCategories.Sections, ModelForSection>!
    
    private var sections = DynamicSections<AllCategories.Sections>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "All categories"
    }
    
    override func setupCollectionView() {
        super.setupCollectionView()
        collectionView.collectionViewLayout = setupCollectionViewLayout()
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupReusableView() {
        super.setupReusableView()
        collectionView.registerCell(AllCategoriesCategoryCell.self)
        
        collectionView.registerHeader(LargeHeaderReusableView.self)
        
        collectionView.registerBackground(
            RoundedBackgroundView.self,
            forDecorationViewOfKind: RoundedBackgroundView.kindView
        )
    }
    
    override func setupDataSource() {
        super.setupDataSource()
        
        dataSource = UICollectionViewDiffableDataSource<AllCategories.Sections, ModelForSection>(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                case .categories:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as AllCategoriesCategoryCell
                    cell.configureCell(category: self?.categories[indexPath.item])
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
                            with: "Expense categories",
                            titleButton: nil,
                            delegate: nil,
                            callBack: nil
                        )
                        return header
                        
                    default:
                        return BaseCollectionReusableView()
                }
            }
            
            return BaseCollectionReusableView()
        }
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
    
    func displayFetchedCategories(viewModel: AllCategories.FetchCategories.ViewModel) {
        self.categories = viewModel.categories
        updateSnapshot()
    }
}

private extension AllCategories.ViewController {
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { _, _ in
            AllCategoriesCategoryCellLayout.layout()
        }
    }
    
    func fetchCategories() {
        let request = AllCategories.FetchCategories.Request()
        interactor?.fetchCategories(request: request)
    }
    
    func updateSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<AllCategories.Sections, ModelForSection>()
        sections.removeAll()
        
        if !categories.isEmpty  {
            sections.appendSection(.categories)
            snapshot.appendSections([.categories])
            let categories = categories.map { ModelForSection.categories($0) }
            snapshot.appendItems(categories, toSection: .categories)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension AllCategories.ViewController: UICollectionViewDelegate {
    
}
