//
//  ListOperationsInteractor.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

final class ListOperationsInteractor: ListOperations.BusinessLogic {
    var presenter: ListOperations.PresentationLogic?
    
    private(set) var operationsPerWeek: [OperationEntity] = []
    private(set) var categoriesPerWeek: [CategoryEntity] = []
    private(set) var operationsPerDay: [OperationEntity] = []
    
    private var coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    
    private let currentCalendar: Calendar = Calendar.current
    private var calendarDays: [CalendarDay] = []
    
    func fetchInitialDataPerWeek(request: ListOperations.FetchInitialWeekData.Request) {
        configureWeekForCalendar(
            weekFromCurrent: request.weekFromCurrent,
            selectedDay: request.weekFromCurrent != 0 ? 0 : nil
        )
        
        let firstOrCurrentDayWeek = calendarDays.first(where: { $0.isCurrent || $0.isSelected })
        
        let startDay = firstOrCurrentDayWeek?.startDay ?? Date.now
        let endDay = firstOrCurrentDayWeek?.endDay ?? Date.now
        
        let operationsPerWeekPredicate = NSPredicate(
            format: "date >= %@ AND date < %@",
            calendarDays[0].date as NSDate,
            calendarDays[6].date as NSDate
        )
        
        let countCategoriesPerWeekPredicate = NSPredicate(
            format: "operations.@count > %d", 0
        )
        
        let categoriesPerWeekPredicate = NSPredicate(
            format: "ANY operations.date >= %@ AND ANY operations.date <= %@",
            calendarDays[0].date as NSDate,
            calendarDays[6].date as NSDate
        )
        
        let compoundCategoriesPerWeekPredicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [countCategoriesPerWeekPredicate, categoriesPerWeekPredicate]
        )
        
        do {
            operationsPerWeek = try coreDataManager.fetchOperations(with: operationsPerWeekPredicate)
            categoriesPerWeek = try coreDataManager.fetchCategories(with: compoundCategoriesPerWeekPredicate)
            
            operationsPerDay = operationsPerWeek.filter({ $0.date >= startDay && $0.date < endDay })
            
            let response = ListOperations.FetchInitialWeekData.Response(
                calendarDays: calendarDays,
                operations: operationsPerDay,
                categories: categoriesPerWeek
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
        operationsPerDay = operationsPerWeek.filter({ $0.date >= request.day.startDay && $0.date < request.day.endDay})
        
        let response = ListOperations.FetchOperationsByWeek.Response(operations: operationsPerDay)
        presenter?.presentFetchedOperationsByWeek(response: response)
    }
}

private extension ListOperations.Interactor {
    func configureWeekForCalendar(weekFromCurrent: Int? = nil, selectedDay: Int? = nil) {
        calendarDays.removeAll()
        
        guard let startOfThisWeek = currentCalendar.dateInterval(
            of: .weekOfYear,
            for: Date.now
        )?.start else { return }
        
        guard let currentDayOfThisWeek = currentCalendar.dateInterval(
            of: .day,
            for: Date.now
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
