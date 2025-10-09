//
//  ColumnData.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import Foundation

struct ColumnData: Codable, Equatable, Identifiable {
    var id: UUID = UUID()
    var date: Date
    var selection: PlayerSelection?
}
