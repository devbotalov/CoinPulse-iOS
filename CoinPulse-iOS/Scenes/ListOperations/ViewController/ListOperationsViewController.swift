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
        collectionView.registerCell(ListOperationsCalendarDayCell.self)
        collectionView.registerCell(ListOperationsCategoryCell.self)
        
        collectionView.registerHeader(LargeHeaderReusableView.self)
        collectionView.registerHeader(CalendarHeaderReusableView.self)
        
        collectionView.registerBackground(
            RoundedBackgroundView.self,
            forDecorationViewOfKind: RoundedBackgroundView.kindView
        )
    }
    
    override func setupDataSource() {
        super.setupDataSource()
        
        // FIXME: Править
        sections.appendSection(.calendar)
        sections.appendSection(.categories)
        
        dataSource = UICollectionViewDiffableDataSource<ListOperations.Sections, Int>(collectionView: collectionView) { [weak self] collectionView, indexPath, _ in
            switch self?.sections.getSection(by: indexPath.section) ?? .unknown {
                case .calendar:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsCalendarDayCell
                    cell.configureCell(
                        shortDay: "S",
                        dayMonth: "12",
                        isCurrent: indexPath.item == 1,
                        isSelected: indexPath.item == 3
                    )
                    return cell
                    
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
                    case .calendar:
                        let header = collectionView.dequeueHeader(for: indexPath) as CalendarHeaderReusableView
                        header.configureView(
                            with: "Hello",
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
            }
            
            return BaseCollectionReusableView()
        }
    }
    
    override func setupInitialSnapshot() {
        super.setupInitialSnapshot()
        
        snapshot = NSDiffableDataSourceSnapshot<ListOperations.Sections, Int>()
        snapshot.appendSections([.calendar])
        snapshot.appendSections([.categories])
        
        snapshot.appendItems([1, 2, 3, 4, 5, 6, 7], toSection: .calendar)
        snapshot.appendItems([8, 9, 10, 11], toSection: .categories)
        
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
                case .calendar:
                    ListOperationsCalendarDayCellLayout.layout(
                        countDay: 7, width: self?.collectionView.frame.width ?? 0
                    )
                case .categories:
                    ListOperationsCategoryCellLayout.layout()
                default:
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

extension ListOperations.ViewController: CalendarHeaderReusableViewDelegate {
    func actionButtonDidTapped(_ sender: UIButton) {
        // Tap
    }
}
