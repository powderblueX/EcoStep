//
//  EnvironmentalProjectsView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct EnvironmentalProjectsView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("步行数据") {
                    WalkingView()
                }
                NavigationLink("骑行数据") {
                    CyclingView()
                }
                NavigationLink("记录环保行为") {
                    RecordBehaviorView()
                }
            }
            .navigationTitle("功能列表")
        }
    }
}

#Preview {
    EnvironmentalProjectsView()
}
