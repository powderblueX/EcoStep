//
//  BehaviorViewModel.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import Foundation


class BehaviorViewModel: ObservableObject {
    @Published var behaviors: [Behavior] = [] // 环保行为记录列表
    @Published var errorMessage: String? = nil // 错误信息



    // 添加环保行为记录
    func addBehavior(type: String, points: Int) {
        
    }

    // 获取用户的所有环保行为
    func fetchBehaviors() {
        
    }
}
