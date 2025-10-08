//
//  UserDefaultsManager.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import Foundation

final class UserDefaultsManager {
    private let columnsKey = "savedColumns"
    
    func saveColumns(_ columns: [ColumnData]) {
        if let data = try? JSONEncoder().encode(columns) {
            UserDefaults.standard.set(data, forKey: columnsKey)
        }
    }
    
    func getColumns() -> [ColumnData] {
        guard let data = UserDefaults.standard.data(forKey: columnsKey),
              let columns = try? JSONDecoder().decode([ColumnData].self, from: data) else {
            return []
        }
        return columns
    }
}
