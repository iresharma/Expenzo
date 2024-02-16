//
//  UntaggedTransactions.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import SwiftUI

struct UntaggedTransactions: View {
    @State private var numbers: [Int] = Array(1...20)
    @State private var isLoading = false
    @State private var isFinished = false
    
    @State private var search = ""
    
    var body: some View {
        List {
            ForEach(numbers, id: \.self) { number in
                if number % 10 == 0 {
                    Section {
                        TransactionListItem()
                    } header: {
                        Text("Week 2, Jan")
                    }
                } else {
                    TransactionListItem()
                }
            }

            if !isFinished {
              ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundColor(.secondary)
                .onAppear {
                  loadMoreContent()
                }
            }
      }.searchable(text: $search)
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
    UntaggedTransactions()
}
