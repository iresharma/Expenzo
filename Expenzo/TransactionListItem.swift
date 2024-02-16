//
//  TransactionListItem.swift
//  Expenzo
//
//  Created by Iresh Sharma on 16/02/24.
//

import SwiftUI

struct TransactionListItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Image(systemName: "message")
                .font(.system(size: 20, weight: .regular, design: .default))
                .foregroundColor(colorScheme == .dark ? .white : .black)
                .frame(width: 50, height: 50)
                .background(colorScheme == .dark ? Color(UIColor.darkGray) : .gray)
                .cornerRadius(15)
                .shadow(radius: 10)
            VStack(alignment: .leading) {
                Text("Ola")
                    .font(.subheadline.bold())
                Text("22nd Jan, 16:19")
                    .font(.subheadline)
            }
            Spacer()
            Text("- ₹100")
                .font(.title2.weight(.semibold))
                .foregroundColor(Bool.random() ? .green : .primary)
        }
    }
}

#Preview {
    TransactionListItem()
}
