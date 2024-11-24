//
//  EditUsernameEmailViewModel.swift
//  EcoStep
//
//  Created by admin on 2024/11/24.
//

import Foundation
import LeanCloud

class EditUsernameEmailViewModel: ObservableObject {
    @Published var newUsername: String = ""
    @Published var newEmail: String = ""
    @Published var errorMessage: ErrorMessage?
    @Published var isButtonDisabled: Bool = true
    @Published var isUsernameEmailUpdated: Bool = false
    @Published var alertType: AlertType? // 统一管理弹窗类型

    private var objectId: String? {
        UserDefaults.standard.string(forKey: "objectId")
    }

    // 初始化输入字段
    func initializeFields(with userInfo: MyInfoModel?) {
        newUsername = userInfo?.username ?? ""
        newEmail = userInfo?.email ?? ""
        validateFields()
    }

    // 验证字段内容
    private func validateFields() {
        isButtonDisabled = newUsername.isEmpty || newEmail.isEmpty
    }

    // 保存修改到 LeanCloud
    func saveChanges(completion: @escaping (Bool) -> Void) {
        guard !newUsername.isEmpty, !newEmail.isEmpty else {
            alertType = .error("用户名和邮箱不能为空")
            completion(false)
            return
        }

        guard let objectId = objectId else {
            alertType = .error("用户未登录")
            completion(false)
            return
        }

        do {
            let user = LCObject(className: "_User", objectId: LCString(objectId))
            try user.set("username", value: newUsername)
            try user.set("email", value: newEmail)

            user.save { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self.isUsernameEmailUpdated = true
                        self.alertType = .success("用户名/电子邮箱更新成功")
                        // 更新 UserDefaults
                        UserDefaults.standard.set(self.newUsername, forKey: "username")
                        completion(true)
                    case .failure(let error):
                        self.alertType = .error("保存失败：\(error.localizedDescription)")
                        completion(false)
                    }
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.alertType = .error("保存失败：\(error.localizedDescription)")
                completion(false)
            }
        }
    }
}
