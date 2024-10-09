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
    
    private var dataSource: UICollectionViewDiffableDataSource<ListOperations.Sections, ModelForSection>!
    private var snapshot: NSDiffableDataSourceSnapshot<ListOperations.Sections, ModelForSection>!
    
    private var sections = DynamicSections<ListOperations.Sections>()
    private var viewModel: ListOperations.FetchData.ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let categoriesPredicate = NSPredicate(format: "operations.@count > %d", 0)
        fetchData(categoriesPredicate: categoriesPredicate)
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
        collectionView.registerCell(ListOperationsCalendarDayCell.self)
        collectionView.registerCell(ListOperationsOperationCell.self)
        collectionView.registerCell(ListOperationsCategoryCell.self)
        
        collectionView.registerHeader(LargeHeaderReusableView.self)
        collectionView.registerHeader(CalendarHeaderReusableView.self)
        
        collectionView.registerFooter(AllOperationsFooterReusableView.self)
        
        collectionView.registerBackground(
            TopRoundedBackgroundView.self,
            forDecorationViewOfKind: TopRoundedBackgroundView.kindView
        )
        
        collectionView.registerBackground(
            BottomRoundedBackgroundView.self,
            forDecorationViewOfKind: BottomRoundedBackgroundView.kindView
        )
        
        collectionView.registerBackground(
            RoundedBackgroundView.self,
            forDecorationViewOfKind: RoundedBackgroundView.kindView
        )
    }
    
    override func setupDataSource() {
        super.setupDataSource()
        
        dataSource = UICollectionViewDiffableDataSource<ListOperations.Sections, ModelForSection>(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                case .calendar:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsCalendarDayCell
                    
                    // FIXME: Fix configureCell
                    cell.configureCell(
                        shortDay: "S",
                        dayMonth: "12",
                        isCurrent: indexPath.item == 1,
                        isSelected: indexPath.item == 3
                    )
                    return cell
                    
                case .operations:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsOperationCell
                    cell.configureCell(with: self?.viewModel?.operations[indexPath.item])
                    return cell
                    
                case .categories:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsCategoryCell
                    cell.configureCell(with: self?.viewModel?.categories[indexPath.item])
                    return cell
                case .unknown:
                    return BaseCollectionViewCell()
            }
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                    case .calendar:
                        let header = collectionView.dequeueHeader(for: indexPath) as CalendarHeaderReusableView
                        
                        // FIXME: Fix configureView
                        header.configureView(
                            with: "Hello",
                            delegate: self
                        )
                        return header
                        
                    case .operations:
                        let header = collectionView.dequeueHeader(for: indexPath) as LargeHeaderReusableView
                        header.configureView(
                            with: "All operations", 
                            titleButton: "View all",
                            delegate: self
                        )
                        return header
                        
                    case .categories:
                        let header = collectionView.dequeueHeader(for: indexPath) as LargeHeaderReusableView
                        header.configureView(
                            with: "Categories",
                            titleButton: "View all",
                            delegate: self
                        )
                        return header
                        
                    default:
                        return BaseCollectionReusableView()
                }
            } else {
                switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                    case .operations:
                        let footer = collectionView.dequeueFooter(for: indexPath) as AllOperationsFooterReusableView
                        footer.configureView(isCollapsed: true, delegate: self)
                        return footer
                    default:
                        return BaseCollectionReusableView()
                }
            }
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
    
    func displayFetchedData(viewModel: ListOperations.FetchData.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.viewModel = viewModel
            self?.updateSnapshot(viewModel: viewModel)
        }
    }
}

private extension ListOperations.ViewController {
    func setupCollectionViewLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.sections.getSection(by: section) ?? .unknown {
                case .calendar:
                    ListOperationsCalendarDayCellLayout.layout(
                        countDay: 7,
                        width: self?.collectionView.frame.width ?? 0,
                        operationsIsEmpty: (self?.viewModel?.operations ?? []).isEmpty
                    )
                    
                case .operations:
                    ListOperationsOperationCellLayout.layout(
                        width: self?.collectionView.frame.width ?? 0
                    )
                case .categories:
                    ListOperationsCategoryCellLayout.layout()
                default:
                    ListOperationsCategoryCellLayout.layout()
            }
        }
    }
    
    func fetchData(operationsPredicate: NSPredicate? = nil, categoriesPredicate: NSPredicate? = nil) {
        let request = ListOperations.FetchData.Request(
            operationsPredicate: operationsPredicate,
            categoriesPredicate: categoriesPredicate
        )
        
        interactor?.fetchData(request: request)
    }
    
    func updateSnapshot(viewModel: ListOperations.FetchData.ViewModel) {
        snapshot = NSDiffableDataSourceSnapshot<ListOperations.Sections, ModelForSection>()
        
        sections.appendSection(.calendar)
        snapshot.appendSections([.calendar])
        
        // FIXME: Fix days
        let days = [1, 2, 3, 4, 5, 6, 7].map { ModelForSection.calendar($0) }
        snapshot.appendItems(days, toSection: .calendar)
        
        if !viewModel.operations.isEmpty {
            sections.appendSection(.operations)
            snapshot.appendSections([.operations])
            let operations = viewModel.operations.map { ModelForSection.operations($0) }
            snapshot.appendItems(operations, toSection: .operations)
        }
        
        if !viewModel.categories.isEmpty {
            sections.appendSection(.categories)
            snapshot.appendSections([.categories])
            let categories = viewModel.categories.map { ModelForSection.categories($0) }
            snapshot.appendItems(categories, toSection: .categories)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ListOperations.ViewController: LargeHeaderReusableViewDelegate {
    func actionButtonDidTapped() {
        // Tap
    }
}

extension ListOperations.ViewController: CalendarHeaderReusableViewDelegate {
    func actionButtonDidTapped(_ sender: UIButton) {
        // Tap
    }
}

extension ListOperations.ViewController: AllOperationsFooterReusableViewDelegate {
    func viewDidTapped() {
        // Tap
    }
}
