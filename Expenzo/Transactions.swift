//
//  Transactions.swift
//  Expenzo
//
//  Created by Iresh Sharma on 16/02/24.
//

import SwiftUI

struct TransactionsView: View {
    @State private var numbers: [Int] = Array(1...20)
      @State private var isLoading = false
      @State private var isFinished = false
    
    @State private var search = ""
    
    @State private var selectedItem = 0
    
    @State private var showingCredits = false
    
    @Environment(\.colorScheme) var colorScheme

      var body: some View {
        NavigationStack {
            VStack {
                Picker("Types of Vehicles - Segmented", selection: $selectedItem) {
                    ForEach(0..<2, id: \.self) { tab in
                        Text(tab == 0 ? "All transactions" : "Untagged Transactions")
                   }
                }
                .pickerStyle(.segmented)
                .padding([.trailing, .leading])
                List {
                    ForEach(numbers, id: \.self) { number in
                        if number % 10 == 0 {
                            Section {
                                TransactionListItem()
                                    .onTapGesture(perform: {
                                        showingCredits.toggle()
                                    })
                            } header: {
                                Text("Week 2, Jan")
                            }
                        } else {
                            TransactionListItem()
                                .onTapGesture(perform: {
                                    showingCredits.toggle()
                                })
                        }
                    }

                    if !isFinished {
                      ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.black)
                        .foregroundColor(.red)
                        .onAppear {
                          loadMoreContent()
                        }
                    }
              }
                .sheet(isPresented: $showingCredits) {
                    TransactionDetailView()
                        .padding()
                        .padding([.top], 20)
                        .presentationDetents([.height(180)])
                    }
                .searchable(text: $search)
                .navigationBarTitle("Transactions", displayMode: .inline)
                .toolbar {
                    Button(action: {}, label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    })
                }
            }
        }
      }

      func loadMoreContent() {
        if !isLoading {
          isLoading = true
          // This simulates an asynchronus call
          DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let moreNumbers = numbers.count + 1...numbers.count + 20
            numbers.append(contentsOf: moreNumbers)
            isLoading = false
            if numbers.count > 250 {
              isFinished = true
            }
          }
        }
      }
}

#Preview {
    TransactionsView()
}
