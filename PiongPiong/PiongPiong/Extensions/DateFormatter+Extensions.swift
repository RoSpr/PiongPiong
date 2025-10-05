//
//  DateFormatter+Extensions.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import Foundation

extension DateFormatter {
    static var tableDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.setLocalizedDateFormatFromTemplate("dd.MM.yy")
        return formatter
    }
}
