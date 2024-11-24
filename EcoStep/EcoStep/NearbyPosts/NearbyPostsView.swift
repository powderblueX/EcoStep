//
//  NearbyPostsView.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import SwiftUI

struct NearbyPostsView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = NearbyPostsViewModel()
    @State private var showPostEditor = false // 控制是否显示创建帖子界面

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                    ForEach(viewModel.posts) { post in
                        VStack {
                            AsyncImage(url: URL(string: post.image)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(height: 150)
                            .clipped()

                            Text(post.content)
                                .font(.headline)
                            Text(post.distance)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
                .padding()
            }

            FloatingButton {
                            showPostEditor = true
                        }
                    }
        .sheet(isPresented: $showPostEditor) {
            PostEditorView { newPost in
                    viewModel.posts.append(newPost)
                }
        }
        .onAppear {
            if let location = locationManager.location {
                viewModel.fetchPosts(lat: location.latitude, lng: location.longitude)
            }
        }
    }
}


#Preview {
    NearbyPostsView()
}
