//
//  SettingsView.swift
//  EcoStep
//
//  Created by admin on 2024/11/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var userInfo: MyInfoModel?

    var body: some View {
        List {
            Section(header: Text("个人信息修改")) {
                NavigationLink(destination: EditUsernameEmailView(userInfo: $userInfo)) {
                    Text("修改用户名和邮箱")
                }

                NavigationLink(destination: EditAvatarView()) {
                    Text("修改头像")
                }
            }

            Section(header: Text("账户安全")) {
                NavigationLink(destination: ChangePasswordView()) {
                    Text("修改密码")
                }
            }
        }
        .navigationTitle("设置")
    }
}

// 定义 ErrorMessage 类型
struct ErrorMessage: Identifiable {
    var id = UUID() // 符合 Identifiable 协议的要求
    var message: String
}
