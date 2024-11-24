//
//  Post.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import Foundation
import UIKit

struct Post: Identifiable, Codable {
    let id: UUID
    let user: String
    let content: String
    let image: String // 图片 URL
    let topic: String
    let distance: String
    
    // 计算属性：解码 Base64 字符串为 UIImage
    var decodedImage: UIImage? {
        guard let data = Data(base64Encoded: image) else { return nil }
        return UIImage(data: data)
    }
}

