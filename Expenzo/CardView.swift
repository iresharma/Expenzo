//
//  CardView.swift
//  Expenzo
//
//  Created by Iresh Sharma on 17/02/24.
//

import SwiftUI

struct CardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    private var backgrounds: [Image] = [
        Image("card-back-1"),
        Image("card-back-2"),
        Image("card-back-4"),
        Image("card-back-5")
    ]
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Bank")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                        .font(.callout)
                        .padding([.trailing], 50)
                        .padding([.top, .bottom], 5)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(5)
                    Text("XXXX XXXX XXXX 1234")
                        .font(.title3)
                        .foregroundColor(.white)
                    Text("Mon 24th, 16:19")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image("bi_sbi")
                    .font(.system(size: 30, weight: .bold))
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                    .cornerRadius(15)
            }
            Spacer()
            Text("₹10,000")
                .font(.title.bold())
                .foregroundColor(.white)
        }
        .padding()
        .background(backgrounds.randomElement()?
            .resizable()
            .aspectRatio(contentMode: .fill))
        .background(Color.black)
        .cornerRadius(8)
        .frame(height: 230)
    }
}

#Preview {
    CardView()
}
