//
//  Transactions.swift
//  Expenzo
//
//  Created by Iresh Sharma on 16/02/24.
//

import SwiftUI

struct TransactionsView: View {
    
    @State private var selectedItem = 0
    
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
                
                if selectedItem == 0 {
                    TaggedTransactions()
                } else {
                    UntaggedTransactions()
                }
            }
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

#Preview {
    TransactionsView()
}
