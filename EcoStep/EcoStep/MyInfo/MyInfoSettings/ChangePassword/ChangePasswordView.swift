//
//  ChangePasswordView.swift
//  EcoStep
//
//  Created by admin on 2024/11/24.
//

import SwiftUI

struct ChangePasswordView: View {
    @StateObject private var viewModel = ChangePasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("当前密码")) {
                SecureField("当前密码", text: $viewModel.currentPassword)
            }
            
            Section(header: Text("新密码")) {
                SecureField("新密码", text: $viewModel.newPassword)
                SecureField("确认新密码", text: $viewModel.confirmPassword)
            }
            
            Button(action: {
                viewModel.updatePassword()
            }) {
                Text("保存更改")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .disabled(viewModel.newPassword.isEmpty || viewModel.currentPassword.isEmpty)
        }
        .onChange(of: viewModel.isPasswordUpdated) {
            if viewModel.isPasswordUpdated {
                presentationMode.wrappedValue.dismiss() // 返回上一级界面
            }
        }
        .alert(item: $viewModel.alertType) { alertType in
            Alert(
                title: Text(alertType.title),
                message: Text(alertType.message),
                dismissButton: .default(Text("好的"), action: {
                    if case .success = alertType {
                        presentationMode.wrappedValue.dismiss() // 成功后返回上一级界面
                    }
                })
            )
        }
        .navigationTitle("修改密码")
    }
}
