//
//  HomeView.swift
//  Expenzo
//
//  Created by Iresh Sharma on 12/02/24.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Income")
                                .font(.caption)
                            Text("1,18,456")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        Spacer()
                        Image(systemName: "arrow.down.right")
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(.green)
                            .frame(width: 35, height: 35)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(10)
                    .padding([.leading, .trailing], 10)
                    .frame(width: UIScreen.main.bounds.size.width * 0.45)
                    .background(Color.green.opacity(0.4))
                    .cornerRadius(10)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Expense")
                                .font(.caption)
                            Text("1,18,456")
                                .font(.system(size: 15, weight: .semibold))
                        }
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(.red)
                            .frame(width: 35, height: 35)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(10)
                    .padding([.leading, .trailing], 10)
                    .frame(width: UIScreen.main.bounds.size.width * 0.45)
                    .background(Color.red.opacity(0.4))
                    .cornerRadius(10)
                }.padding([.top], 25.0)
                ExpenseChart()
                    .frame(height: 300)
                    .background(RadialGradient(gradient: Gradient(colors: [.white, .gray]), center: .center, startRadius: 50, endRadius: 200).opacity(0.3))
                    .cornerRadius(10)
                    .padding()
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Insights").font(.title.bold())
                                Text(getMonth()).font(.subheadline)
                            }
                            Spacer(minLength: 185)
                            HStack {
                                Button(action: {}, label: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 15, weight: .bold, design: .default))
                                })
                                
                                Button(action: {}, label: {
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 15, weight: .bold, design: .default))
                                })
                            }
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        }
                    }
                }
        }
    }
    
    func getMonth() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: now)
        return nameOfMonth
    }
}

#Preview {
    HomeView()
}
