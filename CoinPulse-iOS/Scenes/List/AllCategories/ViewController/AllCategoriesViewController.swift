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
    
    private var viewModel: AllCategories.FetchCategories.ViewModel?
    
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
        
        let addBarButtonItem: UIBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addBarButtonItemTapped)
        )
        
        navigationItem.rightBarButtonItem = addBarButtonItem
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
                case .expense:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as AllCategoriesCategoryCell
                    cell.configureCell(
                        category: self?.viewModel?.expenseCategories?[indexPath.item]
                    )
                    return cell
                    
                case .income:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as AllCategoriesCategoryCell
                    cell.configureCell(
                        category: self?.viewModel?.incomeCategories?[indexPath.item]
                    )
                    return cell
                    
                case .unknown:
                    return BaseCollectionViewCell()
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                    case .expense:
                        let header = collectionView.dequeueHeader(for: indexPath) as LargeHeaderReusableView
                        header.configureView(
                            with: "Expense categories",
                            titleButton: nil,
                            delegate: nil,
                            callBack: nil
                        )
                        return header
                        
                    case .income:
                        let header = collectionView.dequeueHeader(for: indexPath) as LargeHeaderReusableView
                        header.configureView(
                            with: "Income categories",
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
        self.viewModel = viewModel
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
        
        if let expenseCategories = viewModel?.expenseCategories, !expenseCategories.isEmpty {
            sections.appendSection(.expense)
            snapshot.appendSections([.expense])
            let categories = expenseCategories.map { ModelForSection.categories($0) }
            snapshot.appendItems(categories, toSection: .expense)
        }
        
        if let incomeCategories = viewModel?.incomeCategories, !incomeCategories.isEmpty {
            sections.appendSection(.income)
            snapshot.appendSections([.income])
            let categories = incomeCategories.map { ModelForSection.categories($0) }
            snapshot.appendItems(categories, toSection: .income)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc func addBarButtonItemTapped() {
        router?.routeToAddCategory()
    }
}

extension AllCategories.ViewController: UICollectionViewDelegate {
    
}
