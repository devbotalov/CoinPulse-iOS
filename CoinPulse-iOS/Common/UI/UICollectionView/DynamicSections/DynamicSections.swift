//
//  DynamicSections.swift
//  CoinPulse-iOS
//
//  Created by Maksim Botalov on 07.10.2024.
//

import Foundation

struct DynamicSections<T: Hashable> {
    private(set) var sections: [T]
    
    var count: Int { sections.count }
    var isEmpty: Bool { sections.isEmpty }
    var endIndex: Int { sections.endIndex }
    
    init(initialSections: [T] = []) {
        self.sections = initialSections
    }
    
    func getSection(by index: Int) -> T {
        sections[index]
    }
    
    func getIndex(of section: T) -> Int? {
        sections.firstIndex { $0 == section }
    }
    
    func getIndexSet() -> IndexSet {
        IndexSet(sections.indices)
    }
    
    func getIndexSet(of sections: [T]) -> IndexSet {
        let indexes = sections.compactMap {
            section in getIndex(of: section)
        }
        
        return IndexSet(indexes)
    }
    
    func symmetricDifference(_ sections: [T]) -> [T] {
        Array(Set(self.sections).symmetricDifference(Set(sections)))
    }
    
    mutating func appendSection(_ section: T) {
        sections.append(section)
    }
    
    mutating func insertSection(_ section: T, at: Int) {
        sections.insert(section, at: at)
    }
    
    mutating func appendSections(_ sections: [T]) {
        self.sections += sections
    }
}
