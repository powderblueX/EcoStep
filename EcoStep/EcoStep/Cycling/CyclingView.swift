//
//  CyclingView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct CyclingView: View {
    @State private var totalCyclingDistance: Double = 0
    private let healthKitManager = HealthKitManager()
    
    var body: some View {
        VStack {
            Text("骑行数据")
                .font(.title)
                .padding()
            
            Text("总距离: \(totalCyclingDistance, specifier: "%.2f") 米")
        }
        .onAppear {
            // 请求健康数据授权
            healthKitManager.requestAuthorization { success, error in
                if success {
                    // 定义当天的时间范围
                    let now = Date()
                    let startOfDay = Calendar.current.startOfDay(for: now)
                    
                    // 查询骑行距离
                    healthKitManager.fetchActivityData(for: .distanceCycling, startDate: startOfDay, endDate: now) { distance in
                        DispatchQueue.main.async {
                            self.totalCyclingDistance = distance
                        }
                    }
                } else {
                    print("授权失败: \(String(describing: error))")
                }
            }
        }
    }
}

#Preview {
    CyclingView()
}
