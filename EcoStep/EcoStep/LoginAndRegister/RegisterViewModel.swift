//
//  RegisterViewModel.swift
//  EcoStep
//
//  Created by admin on 2024/11/23.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var gender: String = "男"
    @Published var birthday: Date = Date()
    @Published var errorMessage: String = ""
    @Published var isRegistering: Bool = false
    @Published var alertMessage: String = ""// 提示框显示的消息
    @Published var showAlert: Bool = false // 用来控制提示框显示
    
    @Published var confirmPassword: String = ""
    private var userModel: UserModel
    
    init(userModel: UserModel = UserModel()) {
        self.userModel = userModel
    }
    
    func register() {
        // 清除之前的错误信息
        errorMessage = ""
        
        // 验证密码不能为空
        guard !password.isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "密码不能为空"
            return
        }
        
        // 验证性别是否合法
        guard gender == "男" || gender == "女" else {
            errorMessage = "性别为男/女"
            return
        }
        
        // 开始注册
        isRegistering = true
        userModel.register(username: username, password: password, email: email, gender: gender, birthday: birthday) { result in
            DispatchQueue.main.async {
                self.isRegistering = false
                switch result {
                case .success(let user):
                    // 注册成功
                    self.alertMessage = "注册成功！"
                    self.showAlert = true
                    print("User registered: \(user)") // 输出注册的用户对象
                case .failure(let error):
                    // 注册失败
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // 重置所有字段
    func reset() {
        username = ""
        password = ""
        confirmPassword = ""
        email = ""
        gender = "男"
        birthday = Date()
        errorMessage = ""
    }
}
