//
//  MainTabView.swift
//  EcoStep
//
//  Created by admin on 2024/11/19.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // 环保项目
            EnvironmentalProjectsView()
                .tabItem {
                    Image(systemName: "leaf")
                    Text("环保项目")
                }
            
            // 附近论坛
            NearbyPostsView()
                .tabItem {
                    Image(systemName: "message")
                    Text("附近论坛")
                }
            
            // 我的树
            MyTreeView()
                .tabItem {
                    Image(systemName: "tree")
                    Text("我的树")
                }
            
            // 个人信息
            MyInfoView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("我")
                }
        }
        .accentColor(.green) // 设置底部导航栏图标的选中颜色
    }
}

#Preview {
    MainTabView()
}
