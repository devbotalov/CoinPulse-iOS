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
    private var calendarDays: [CalendarDay] = []
    private var operations: [OperationEntity] = []
    private var categories: [CategoryEntity] = []
    
    private var weekFromCurrent: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInitialData()
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
                    cell.configureCell(day: self?.calendarDays[indexPath.item])
                    return cell
                    
                case .operations:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsOperationCell
                    cell.configureCell(with: self?.operations[indexPath.item])
                    return cell
                    
                case .categories:
                    let cell = collectionView.dequeueReusableCell(for: indexPath) as ListOperationsCategoryCell
                    cell.configureCell(with: self?.categories[indexPath.item])
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
                            with: "Calendar",
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
    
    func displayFetchedInitialData(viewModel: ListOperations.FetchInitialData.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.calendarDays = viewModel.calendarDays
            self?.operations = viewModel.operations
            self?.categories = viewModel.categories
            self?.updateSnapshot()
        }
    }
    
    func displayFetchedWeekOfCalendar(viewModel: ListOperations.FetchWeekOfCalendar.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.calendarDays = viewModel.calendarDays
            self?.updateSnapshot()
        }
    }
    
    func displayFetchedOperationsByWeek(viewModel: ListOperations.FetchOperationsByWeek.ViewModel) {
        DispatchQueue.main.async { [weak self] in
            self?.operations = viewModel.operations
            self?.updateSnapshot()
        }
    }
}

extension ListOperations.ViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sections.getSection(by: indexPath.section) {
            case .calendar:
                guard !calendarDays[indexPath.item].isSelected else { return }
                
                fetchWeekOfCalendar(
                    selectedDay: indexPath.item,
                    weekFromCurrent: weekFromCurrent
                )
                
                fetchOperationsByDay(day: calendarDays[indexPath.item])
            default:
                break
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
                        operationsIsEmpty: (self?.operations ?? []).isEmpty
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
    
    func fetchInitialData() {
        let request = ListOperations.FetchInitialData.Request(weekFromCurrent: weekFromCurrent)
        interactor?.fetchInitialData(request: request)
    }
    
    func fetchWeekOfCalendar(selectedDay: Int? = nil, weekFromCurrent: Int? = nil) {
        let request = ListOperations.FetchWeekOfCalendar.Request(
            selectedDay: selectedDay,
            weekFromCurrent: weekFromCurrent
        )
        
        interactor?.fetchWeekOfCalendar(request: request)
    }
    
    func fetchOperationsByDay(day: CalendarDay) {
        let request = ListOperations.FetchOperationsByWeek.Request(day: day)
        
        interactor?.fetchOperationsByDay(request: request)
    }
    
    func updateSnapshot() {
        snapshot = NSDiffableDataSourceSnapshot<ListOperations.Sections, ModelForSection>()
        sections.removeAll()
        
        if !calendarDays.isEmpty  {
            sections.appendSection(.calendar)
            snapshot.appendSections([.calendar])
            let calendarDays = calendarDays.map { ModelForSection.calendar($0) }
            snapshot.appendItems(calendarDays, toSection: .calendar)
        }
        
        if !operations.isEmpty  {
            sections.appendSection(.operations)
            snapshot.appendSections([.operations])
            let operations = operations.map { ModelForSection.operations($0) }
            snapshot.appendItems(operations, toSection: .operations)
        }
        
        if !categories.isEmpty  {
            sections.appendSection(.categories)
            snapshot.appendSections([.categories])
            let categories = categories.map { ModelForSection.categories($0) }
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
        switch sender.tag {
            case 0:
                weekFromCurrent -= 1
                fetchWeekOfCalendar(weekFromCurrent: weekFromCurrent)
            case 1:
                weekFromCurrent += 1
                fetchWeekOfCalendar(weekFromCurrent: weekFromCurrent)
            default:
                break
        }
    }
}

extension ListOperations.ViewController: AllOperationsFooterReusableViewDelegate {
    func viewDidTapped() {
        // Tap
    }
}
