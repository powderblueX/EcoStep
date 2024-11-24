//
//  EcoStepApp.swift
//  EcoStep
//
//  Created by admin on 2024/11/23.
//

import SwiftUI

@main
struct EcoStepApp: App {
    // 将 AppDelegate 注入到 SwiftUI 应用中
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                Group {
                    if viewModel.isLoggedIn {
                        MainTabView() // 跳转到主页面
                    } else {
                        LoginView(viewModel: viewModel)
                    }
                }
                .animation(.easeInOut, value: viewModel.isLoggedIn) //  优化：为登录状态变化添加平滑动画
                .onAppear {
                    viewModel.autoLogin() // 自动登录
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("提示"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("确定"))
                )
            }
        }
    }
}

// powderblueX
// powderblue437

