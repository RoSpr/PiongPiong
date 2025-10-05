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
    @AppStorage("firstPlayerName") var firstPlayerName: String = "Player 1"
    @AppStorage("secondPlayerName") var secondPlayerName: String = "Player 2"
    
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
                    Text("")
                        .frame(width: 70, height: 20)
                    
                    TextField(firstPlayerName, text: $firstPlayerName)
                        .frame(width: 70, height: 50)
                        .padding([.leading, .trailing], 10)
                        
                    TextField(secondPlayerName, text: $secondPlayerName)
                        .frame(width: 70, height: 50)
                        .padding([.leading, .trailing], 10)
                }
                
                ScrollView(.horizontal) {
                    Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                        HStack {
                            GridRow {
                                ForEach(viewModel.columns.indices, id: \.self) { index in
                                    HStack {
                                        Text(DateFormatter.tableDate.string(from: viewModel.columns[index].date))
                                            .frame(height: 20, alignment: .center)
                                            .minimumScaleFactor(0.75)
                                            .multilineTextAlignment(.center)
                                            .font(.footnote)
                                        Button(action: {
                                            viewModel.removeEntryAt(index: index)
                                        }) {
                                            Image(systemName: "x.circle")
                                                .font(.caption2)
                                                .foregroundColor(.red)
                                        }
                                    }
                                    .frame(width: 65, height: 15)
                                }
                            }
                            .frame(width: 65)
                        }
                        
                        HStack {
                            GridRow {
                                ForEach(viewModel.columns.indices, id: \.self) { index in
                                    SelectableCell(isSelected: viewModel.columns[index].selection == .firstPlayer, action: {
                                        viewModel.selectInRow(index, selection: .firstPlayer)
                                    })
                                }
                            }
                            .frame(width: 65, height: 65)
                        }
                        
                        HStack {
                            GridRow {
                                ForEach(viewModel.columns.indices, id: \.self) { index in
                                    SelectableCell(isSelected: viewModel.columns[index].selection == .secondPlayer) {
                                        viewModel.selectInRow(index, selection: .secondPlayer)
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
