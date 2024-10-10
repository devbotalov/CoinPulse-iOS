//
//  ListOperationsInteractor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsInteractor: ListOperations.BusinessLogic {
    var presenter: ListOperations.PresentationLogic?
    
    private(set) var operations: [OperationEntity] = []
    private(set) var categories: [CategoryEntity] = []
    
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    
    private let currentCalendar: Calendar = Calendar.current
    private let currentDate: Date = Date.now
    private var currentInitialDate: (startDay: Date, endDate: Date) {
        let startDay = currentCalendar.startOfDay(
            for: currentDate
        )
        let endDay = currentCalendar.date(
            byAdding: .day,
            value: 1,
            to: startDay
        )?.addingTimeInterval(-1) ?? Date.now
        
        return (startDay, endDay)
    }
    
    private var calendarDays: [CalendarDay] = []
    
    func fetchInitialData(request: ListOperations.FetchInitialData.Request) {
        configureWeekForCalendar(weekFromCurrent: request.weekFromCurrent)
        
        let operationsPredicate = NSPredicate(
            format: "date >= %@ AND date < %@",
            currentInitialDate.startDay as NSDate,
            currentInitialDate.endDate as NSDate
        )
        
        let categoriesPredicate = NSPredicate(
            format: "operations.@count > %d", 0
        )
        
        do {
            operations = try coreDataManager.fetchOperations(with: operationsPredicate)
            categories = try coreDataManager.fetchCategories(with: categoriesPredicate)
            
            let response = ListOperations.FetchInitialData.Response(
                calendarDays: calendarDays,
                operations: operations,
                categories: categories
            )
            
            presenter?.presentFetchedInitialData(response: response)
        } catch let error {
            // FIXME: Display notifications error
            print("===", error.localizedDescription)
        }
    }
    
    func fetchWeekOfCalendar(request: ListOperations.FetchWeekOfCalendar.Request) {
        configureWeekForCalendar(
            weekFromCurrent: request.weekFromCurrent,
            selectedDay: request.selectedDay
        )
        
        let response = ListOperations.FetchWeekOfCalendar.Response(calendarDays: calendarDays)
        presenter?.presentFetchedWeekOfCalendar(response: response)
    }
    
    func fetchOperationsByDay(request: ListOperations.FetchOperationsByWeek.Request) {
        let startOfDay = currentCalendar.startOfDay(
            for: request.day.date
        )
        let endOfDay = currentCalendar.date(
            byAdding: .day,
            value: 1,
            to: startOfDay
        )?.addingTimeInterval(-1) ?? Date.now
        
        let predicate = NSPredicate(
            format: "date >= %@ AND date < %@",
            startOfDay as NSDate,
            endOfDay as NSDate
        )
        
        do {
            operations = try coreDataManager.fetchOperations(
                with: predicate
            )
            
            let response = ListOperations.FetchOperationsByWeek.Response(operations: operations)
            presenter?.presentFetchedOperationsByWeek(response: response)
        } catch let error {
            // FIXME: Display notifications error
            print("===", error.localizedDescription)
        }
    }
}

private extension ListOperations.Interactor {
    func configureWeekForCalendar(weekFromCurrent: Int? = nil, selectedDay: Int? = nil) {
        calendarDays.removeAll()
        
        guard let startOfThisWeek = currentCalendar.dateInterval(
            of: .weekOfYear,
            for: currentDate
        )?.start else { return }
        
        guard let currentDayOfThisWeek = currentCalendar.dateInterval(
            of: .day,
            for: currentDate
        )?.start else { return }
        
        guard let startOfPreviousWeek = currentCalendar.date(
            byAdding: .weekOfYear,
            value: weekFromCurrent ?? 0,
            to: startOfThisWeek
        ) else { return }
        
        for day in 0..<7 {
            if let date = currentCalendar.date(byAdding: .day, value: day, to: startOfPreviousWeek) {
                let titleDateFormatter = DateFormatter()
                titleDateFormatter.dateFormat = "EEEEEE"
                
                let numberDateFormatter = DateFormatter()
                numberDateFormatter.dateFormat = "d"
                
                calendarDays.append(CalendarDay(
                    title: titleDateFormatter.string(from: date),
                    number: numberDateFormatter.string(from: date),
                    isCurrent: currentDayOfThisWeek == date,
                    isSelected: day == selectedDay,
                    date: currentCalendar.startOfDay(for: date)
                ))
            }
        }
    }
}
