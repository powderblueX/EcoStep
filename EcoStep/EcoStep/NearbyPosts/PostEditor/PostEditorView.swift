//
//  PostEditorView.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import SwiftUI
import PhotosUI

struct PostEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var postTitle: String = ""
    @State private var postContent: String = ""
    @State private var selectedImages: [UIImage] = []
    @State private var customTopic: String = ""
    @State private var selectedTopic: String = "#我为环保做贡献"
    @State private var availableTopics: [String] = ["#我为环保做贡献", "#环保达人", "#绿色生活"]
    @State private var showPhotoPicker = false
    @State private var showCamera = false

    var onPostCreated: (Post) -> Void

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // 标题输入
                    TextField("请输入标题（必填）", text: $postTitle)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)

                    // 内容输入
                    TextEditor(text: $postContent)
                        .frame(height: 150)
                        .padding()
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            Text(postContent.isEmpty ? "请输入内容（选填）" : "")
                                .foregroundColor(.gray)
                                .padding(.leading, 8),
                            alignment: .topLeading
                        )

                    // 选择图片
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(selectedImages, id: \.self) { image in
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            // 添加图片按钮
                            Button(action: { showPhotoPicker = true }) {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                    .frame(width: 100, height: 100)
                                    .background(Color(UIColor.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            // 拍照按钮
                            Button(action: { showCamera = true }) {
                                Image(systemName: "camera")
                                    .font(.largeTitle)
                                    .foregroundColor(.blue)
                                    .frame(width: 100, height: 100)
                                    .background(Color(UIColor.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }

                    // 话题选择
                    VStack(alignment: .leading) {
                        Text("选择或创建话题：")
                            .font(.headline)

                        Picker("选择话题", selection: $selectedTopic) {
                            ForEach(availableTopics, id: \.self) { topic in
                                Text(topic).tag(topic)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())

                        TextField("创建自定义话题", text: $customTopic)
                            .padding()
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(8)
                            .onSubmit {
                                if !customTopic.isEmpty {
                                    availableTopics.append(customTopic)
                                    selectedTopic = customTopic
                                    customTopic = ""
                                }
                            }
                    }

                    // 提交按钮
                    Button(action: createPost) {
                        Text("发送")
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .foregroundColor(.white)
                            .background(postTitle.isEmpty ? Color.gray : Color.blue)
                            .cornerRadius(10)
                    }
                    .disabled(postTitle.isEmpty)
                }
                .padding()
            }
            .navigationTitle("创建帖子")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showPhotoPicker) {
                PhotoPicker(selectedImages: $selectedImages)
            }
            .sheet(isPresented: $showCamera) {
                CameraView(selectedImage: $selectedImages)
            }
        }
    }

    private func createPost() {
        // 如果选择了图片，将图片转为 Base64 格式
        _ = selectedImages.first?.jpegData(compressionQuality: 0.8)?.base64EncodedString() ?? ""
        let newPost = Post(
            id: UUID(), // 使用 UUID 类型
            user: "currentUser", // 替换为当前用户的用户名
            content: postContent,
            image: selectedImages.first?.pngData()?.base64EncodedString() ?? "",
            topic: selectedTopic, // 选择的话题，或默认话题
            distance: "0km" // 示例距离，可以根据逻辑调整
        )
        onPostCreated(newPost)
        dismiss()
    }
}



