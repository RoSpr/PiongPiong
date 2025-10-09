//
//  MainView.swift
//  PiongPiong
//
//  Created by Rodion on 05/10/2025.
//

import SwiftUI
import Combine

struct MainView: View {
    @StateObject var viewModel: TableViewModel
    @AppStorage(UserDefaultsKeys.firstPlayerName.rawValue) var firstPlayerName: String = "Player 1"
    @AppStorage(UserDefaultsKeys.secondPlayerName.rawValue) var secondPlayerName: String = "Player 2"
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button(action: {
                    viewModel.addNewEntry()
                }, label: {
                    Text("Add new game")
                        .font(.subheadline)
                        .bold()
                })
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 20))
            }
            
            HStack {
                Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                    HStack {
                        Button(action: {
                            viewModel.isUIBlocked.toggle()
                        }, label: {
                            Image(systemName: viewModel.isUIBlocked ? "lock" : "lock.open")
                        })
                        
                        Spacer()
                            .frame(width: 45, height: 20)
                    }
                    
                    TextField(firstPlayerName, text: $firstPlayerName)
                        .frame(width: 70, height: 50)
                        .padding([.leading, .trailing], 10)
                        .disabled(viewModel.isUIBlocked)
                        
                    TextField(secondPlayerName, text: $secondPlayerName)
                        .frame(width: 70, height: 50)
                        .padding([.leading, .trailing], 10)
                        .disabled(viewModel.isUIBlocked)
                }
                
                ScrollView(.horizontal) {
                    Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                        HStack {
                            GridRow {
                                ForEach(viewModel.columns) { column in
                                    HStack {
                                        Text(DateFormatter.tableDate.string(from: column.date))
                                            .frame(height: 20, alignment: .center)
                                            .minimumScaleFactor(0.75)
                                            .multilineTextAlignment(.center)
                                            .font(.footnote)
                                        Button(action: {
                                            if let index = viewModel.columns.firstIndex(where: { column.id == $0.id }) {
                                                viewModel.removeEntryAt(index: index)
                                            }
                                        }) {
                                            Image(systemName: "x.circle")
                                                .font(.caption2)
                                                .foregroundColor(viewModel.isUIBlocked ? Color.gray : .red)
                                                .padding([.leading], -5)
                                                .animation(.default, value: viewModel.isUIBlocked)
                                        }
                                    }
                                    .frame(width: 65, height: 15)
                                }
                            }
                            .frame(width: 65)
                        }
                        
                        HStack {
                            GridRow {
                                ForEach(viewModel.columns) { column in
                                    SelectableCell(isSelected: column.selection == .firstPlayer, isUIBlocked: viewModel.isUIBlocked) {
                                        if let index = viewModel.columns.firstIndex(where: { column.id == $0.id }) {
                                            viewModel.selectInRow(index, selection: .firstPlayer)
                                        }
                                    }
                                }
                            }
                            .frame(width: 65, height: 65)
                        }
                        
                        HStack {
                            GridRow {
                                ForEach(viewModel.columns) { column in
                                    SelectableCell(isSelected: column.selection == .secondPlayer, isUIBlocked: viewModel.isUIBlocked) {
                                        if let index = viewModel.columns.firstIndex(where: { column.id == $0.id }) {
                                            viewModel.selectInRow(index, selection: .secondPlayer)
                                        }
                                    }
                                }
                            }
                            .frame(width: 65, height: 65)
                        }
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.secondary, lineWidth: 1)
            )
            
            HStack {
                VStack {
                    HStack {
                        Text("\(firstPlayerName): \(viewModel.firstPlayerWins) wins")
                            .font(.subheadline)
                        Spacer()
                        Text("Number of games: \(viewModel.gamesTotal)")
                            .font(.subheadline)
                    }
                    
                    HStack {
                        Text("\(secondPlayerName): \(viewModel.secondPlayerWins) wins")
                            .font(.subheadline)
                        Spacer()
                    }
                }
            }
            .padding(.top, 5)
        }
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 10, trailing: 10))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    MainView(viewModel: TableViewModel())
}
