//
//  AccountsView.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import SwiftUI

struct AccountsView: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ForEach(0..<5) { index in
                    CardView()
                }
            }
            .padding()
            .navigationTitle("Accounts")
        }
    }
}

#Preview {
    AccountsView()
}
