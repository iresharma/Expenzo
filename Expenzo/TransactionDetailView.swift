//
//  TransactionDetailView.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import SwiftUI

struct TransactionDetailView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Expanse")
                        .multilineTextAlignment(.leading)
                        .font(.callout)
                        .padding([.trailing, .leading], 30)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(5)
                    Text("₹10,000")
                        .font(.title.bold())
                    Text("Mon 24th, 16:19")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "message")
                    .font(.system(size: 30, weight: .bold))
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .background(colorScheme == .dark ? Color(UIColor.darkGray) : .gray)
                    .cornerRadius(15)
                    .shadow(radius: 20)
            }
            Spacer(minLength: 20)
            HStack {
                VStack(alignment: .leading) {
                    Text("₹1.23.456")
                        .fontWeight(.bold)
                    Text("XXXX XXXX XXXX 1234")
                        .font(.caption)
                }
                Spacer()
                Image("bi_hsbc")
                    .cornerRadius(1000)
            }
            .padding(10)
            .background(Color.red.opacity(0.5))
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}

#Preview {
    TransactionDetailView()
}
