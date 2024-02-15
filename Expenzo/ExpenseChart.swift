//
//  ExpenseChart.swift
//  Expenzo
//
//  Created by Iresh Sharma on 12/02/24.
//

import SwiftUI
import Charts

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let revenue: Double
    let color: Color
}

struct ExpenseChart: View {
    @State private var products: [Product] = [
        .init(title: "Investment", revenue: 20000, color: .green),
        .init(title: "Education Loan", revenue: 20000, color: .black),
        .init(title: "Rent", revenue: 18000, color: .blue),
        .init(title: "Bike testing EMI", revenue: 8000, color: .pink),
        .init(title: "Slice", revenue: 5000, color: .purple),
        .init(title: "Food", revenue: 7000, color: .yellow),
        .init(title: "Gaming", revenue: 2500, color: .red)
    ]
    
    @State private var selected: Double? = nil
    
    var cumulativeIncomes: [(title: String, range: Range<Double>)] = []
    
    init() {
            var cumulative = 0.0
        self.cumulativeIncomes = products.map {
                let newCumulative = cumulative + Double($0.revenue)
                let result = (title: $0.title, range: cumulative ..< newCumulative)
                cumulative = newCumulative
                return result
            }
        }
    
    var mid: Product? {
            if let selected,
               let selectedIndex = cumulativeIncomes
                .firstIndex(where: { $0.range.contains(selected) }) {
                return products[selectedIndex]
            }
            return nil
        }
    
    var body: some View {
        ZStack {
            Chart(products) { product in
                SectorMark(
                    angle: .value(
                        Text(verbatim: product.title),
                        product.revenue
                    ),
                    innerRadius: .ratio(0.65),
                    outerRadius: mid?.title == product.title ? .ratio(0.95) : .ratio(0.85),
                    angularInset: 3
                )
                .cornerRadius(10)
                .foregroundStyle(by: .value("Revenue", product.title))
            }
            .chartAngleSelection(value: $selected)
            .chartForegroundStyleScale(domain: products.map { $0.title }, range: products.map { $0.color })
            .chartLegend(.hidden)
            VStack {
                Text(mid?.title ?? "Most Expenditure")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text(mid != nil ? String(format: "%.2f", mid?.revenue ?? 10) : "Investments")
                    .font(.title3.bold())
                    .foregroundStyle(.black)
            }
        }
    }
}

#Preview {
    ExpenseChart()
}
