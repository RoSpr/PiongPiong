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
        
        bind()
    }
    
    private func bind() {
        $columns
            .sink { [weak self] newValue in
                guard let self = self else { return }
                self.udHelper.saveColumns(newValue)
                self.gamesTotal = newValue.count
                self.countWins(newValue)
            }
            .store(in: &cancellables)
    }
    
    private func countWins(_ columns: [ColumnData]) {
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
        
        countWins(columns)
        udHelper.saveColumns(columns)
    }
    
    func addNewEntry() {
        let newColumn = ColumnData(date: Date(), selection: nil)
        columns.append(newColumn)
        gamesTotal = columns.count
    }
}
