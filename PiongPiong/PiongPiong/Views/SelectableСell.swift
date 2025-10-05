//
//  SelectableСell.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import SwiftUI

struct SelectableCell: View {
    var isSelected: Bool = false
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 10)
                .fill(isSelected ? Color.blue.opacity(0.7) : Color.red.opacity(0.5))
        }
        .frame(width: 64, height: 64)
        .contentShape(Rectangle())
        .buttonStyle(.plain)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.secondary, lineWidth: 1)
                .allowsHitTesting(false)
        )
        .contentShape(Rectangle())
    }
}
