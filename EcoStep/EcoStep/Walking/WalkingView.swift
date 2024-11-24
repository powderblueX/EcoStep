//
//  WalkingView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct WalkingView: View {
    @State private var totalWalkingDistance: Double = 0
    @State private var totalSteps: Int = 0
    private let healthKitManager = HealthKitManager()
    
    var body: some View {
        VStack {
            Text("步行数据")
                .font(.title)
                .padding()
            
            Text("总距离: \(totalWalkingDistance, specifier: "%.2f") 米")
            Text("步数: \(totalSteps)")
        }
        .onAppear {
            // 请求健康数据授权
            healthKitManager.requestAuthorization { success, error in
                if success {
                    // 定义当天的时间范围
                    let now = Date()
                    let startOfDay = Calendar.current.startOfDay(for: now)
                    
                    // 查询步行距离
                    healthKitManager.fetchActivityData(for: .distanceWalkingRunning, startDate: startOfDay, endDate: now) { distance in
                        DispatchQueue.main.async {
                            self.totalWalkingDistance = distance
                        }
                    }
                    
                    // 查询步数
                    healthKitManager.fetchActivityData(for: .stepCount, startDate: startOfDay, endDate: now) { steps in
                        DispatchQueue.main.async {
                            self.totalSteps = Int(steps)
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
    WalkingView()
}
