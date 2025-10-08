//
//  UserDefaultsManager.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import Foundation

final class UserDefaultsManager {
    func saveColumns(_ columns: [ColumnData]) {
        if let data = try? JSONEncoder().encode(columns) {
            UserDefaults.standard.set(data, forKey: UserDefaultsKeys.columnKey.rawValue)
        }
    }
    
    func getColumns() -> [ColumnData] {
        guard let data = UserDefaults.standard.data(forKey: UserDefaultsKeys.columnKey.rawValue),
              let columns = try? JSONDecoder().decode([ColumnData].self, from: data) else {
            return []
        }
        return columns
    }
    
    func saveValue(_ value: Any, key: UserDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getValue(_ key: UserDefaultsKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
}
