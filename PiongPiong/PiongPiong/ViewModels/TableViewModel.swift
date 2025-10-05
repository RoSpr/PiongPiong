//
//  TableViewModel.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import Foundation
import Combine

final class TableViewModel: ObservableObject {
    private let udHelper = UserDefaultsManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var columns: [ColumnData] = []
    @Published var firstPlayerWins: Int = 0
    @Published var secondPlayerWins: Int = 0
    @Published var gamesTotal: Int = 0
    
    init() {
        columns = udHelper.getColumns()
        countWins()
        gamesTotal = columns.count
    }
    
    private func countWins() {
        firstPlayerWins = columns.filter({ $0.selection == .firstPlayer }).count
        secondPlayerWins = columns.filter({ $0.selection == .secondPlayer }).count
    }
    
    func selectInRow(_ index: Int, selection: PlayerSelection) {
        guard columns.indices.contains(index) else { return }
        if columns[index].selection == selection {
            columns[index].selection = nil
        } else {
            columns[index].selection = selection
        }
        
        countWins()
        udHelper.saveColumns(columns)
    }
    
    func addNewEntry() {
        let newColumn = ColumnData(date: Date(), selection: nil)
        columns.append(newColumn)
        udHelper.saveColumns(columns)
        gamesTotal = columns.count
    }
}
