//
//  MyInfoView.swift
//  EcoStep
//
//  Created by admin on 2024/11/23.
//

import SwiftUI

import SwiftUI
import Kingfisher

struct MyInfoView: View {
    @StateObject private var viewModel = MyInfoViewModel()

    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ProgressView("加载中...")
            } else if let userInfo = viewModel.userInfo {
                ScrollView {
                    VStack(spacing: 20) {
                        // 用户头像
                        if let avatarURL = userInfo.avatarURL {
                            KFImage(URL(string: avatarURL.absoluteString))
                                .placeholder {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipShape(Circle())
                                        .foregroundColor(.gray)
                                }
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                        } else {
                            // 如果 avatarURL 为空，显示默认头像
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .foregroundColor(.gray)  // 默认头像颜色
                        }
                        
                        // 用户名、邮箱
                        Text(userInfo.username).font(.title)
                        Text(userInfo.email).font(.subheadline).foregroundColor(.gray)
                        
                        // 用户性别和生日
                        HStack {
                            Text("性别: \(userInfo.gender)")
                            Spacer()
                            if let birthday = userInfo.birthday {
                                Text("生日: \(birthday, style: .date)")
                            }
                        }
                        .padding(.horizontal)
                        
                        // 用户帖子和收藏
                        Section(header: Text("我的帖子")) {
                            ForEach(userInfo.posts) { post in
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    Text(post.title)
                                }
                            }
                        }

                        Section(header: Text("我的收藏")) {
                            ForEach(userInfo.favorites) { post in
                                NavigationLink(destination: PostDetailView(post: post)) {
                                    Text(post.title)
                                }
                            }
                        }
                        
                        // 设置按钮
                        NavigationLink("设置", destination: SettingsView(userInfo: $viewModel.userInfo))
                            .buttonStyle(.borderedProminent)
                        
                        // 退出登录
                        Button("退出登录") {
                            viewModel.logout()
                        }
                        .foregroundColor(.red)
                    }
                    .padding()
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("加载失败: \(errorMessage)")
            }
        }
        .onAppear {
            // 视图每次出现时重新加载用户信息
            viewModel.fetchUserInfo()
        }
    }
}

// 帖子详情视图
struct PostDetailView: View {
    let post: MyInfoModel.Post

    var body: some View {
        Text(post.content)
            .navigationTitle(post.title)
    }
}


