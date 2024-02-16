//
//  ContentView.swift
//  Expenzo
//
//  Created by Iresh Sharma on 11/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedIndex = 2
    
    @Environment(\.colorScheme) var colorScheme
    
    private var icons = ["chart.bar.doc.horizontal", "circle.grid.cross.fill", "creditcard", "bolt.heart"]

    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    TransactionsView()
                case 1:
                    HomeView()
                case 2:
                    AccountsView()
                case 3:
                    NavigationView {
                        VStack {
                            Text("hello")
                                .navigationTitle("Fourth")
                        }
                    }
                default:
                    Text("hello")
                }
            }
            HStack {
                ForEach(0..<4, id: \.self) {number in
                    Spacer()
                    Button(action: {
                        self.selectedIndex = number
                    }, label: {
                        Image(systemName: icons[number])
                            .font(.system(
                                size: 25,
                                weight: .regular,
                                design: .default
                            ))
                            .foregroundColor(getForegroundColor(number))
                            .frame(width: 50, height: 50)
                            .background(getBackgroundColor(number))
                            .cornerRadius(10.0)
                    })
                    Spacer()
                }
            }
        }
    }
    
    func getBackgroundColor(_ number: Int) -> Color {
        if colorScheme == .light {
            return selectedIndex == number ? .black : .white
        }
        return selectedIndex == number ? .white : .black
    }
    
    func getForegroundColor(_ number: Int) -> Color {
        if colorScheme == .light {
            return selectedIndex == number ? .white : Color(UIColor.lightGray)
        }
        return selectedIndex == number ? .black : Color(UIColor.lightGray)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
