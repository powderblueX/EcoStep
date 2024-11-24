//
//  RecordBehaviorView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct RecordBehaviorView: View {
    @StateObject private var viewModel = BehaviorViewModel() // 创建 ViewModel 实例
    @State private var behaviorType: String = "" // 用户输入的行为类型
    @State private var behaviorPoints: String = "" // 用户输入的积分
    @State private var showAlert: Bool = false // 是否显示提示

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("记录环保行为")) {
                        TextField("行为类型（如步行上班）", text: $behaviorType)
                        TextField("奖励积分", text: $behaviorPoints)
                            .keyboardType(.numberPad)
                    }

                    Button(action: {
                        if let points = Int(behaviorPoints) {
                            viewModel.addBehavior(type: behaviorType, points: points)
                            behaviorType = "" // 清空输入框
                            behaviorPoints = ""
                            showAlert = true
                        }
                    }) {
                        Text("保存记录")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }

                Section(header: Text("已记录的环保行为")) {
                    List(viewModel.behaviors) { behavior in
                        VStack(alignment: .leading) {
                            Text(behavior.type)
                                .font(.headline)
                            Text("积分: \(behavior.points)")
                                .font(.subheadline)
                            Text("时间: \(behavior.timestamp.formatted())")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("提示"), message: Text("行为记录已保存！"), dismissButton: .default(Text("确定")))
            }
            .navigationTitle("环保行为记录")
            .onAppear {
                viewModel.fetchBehaviors() // 加载数据
            }
        }
    }
}

