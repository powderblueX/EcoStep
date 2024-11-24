//
//  NearbyPostsViewModel.swift
//  EcoStep
//
//  Created by admin on 2024/11/20.
//

import Foundation
import Combine
import UIKit

class NearbyPostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchPosts(lat: Double, lng: Double) {
        guard let url = URL(string: "https://your-api.com/posts?lat=\(lat)&lng=\(lng)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Failed to fetch posts: \(error)")
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
            })
            .store(in: &cancellables)
    }

    func createPost(title: String, content: String, image: UIImage?, topic: String) {
        guard let url = URL(string: "https://your-api.com/create-post") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let formData = createFormData(title: title, content: content, image: image, topic: topic, boundary: boundary)
        request.httpBody = formData

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Failed to create post: \(error)")
            } else {
                print("Post created successfully")
            }
        }.resume()
    }

    private func createFormData(title: String, content: String, image: UIImage?, topic: String, boundary: String) -> Data {
        var data = Data()
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(title)\r\n".data(using: .utf8)!)
        
        if let image = image {
            let imageData = image.jpegData(compressionQuality: 0.8)!
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(imageData)
            data.append("\r\n".data(using: .utf8)!)
        }

        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"topic\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(topic)\r\n".data(using: .utf8)!)
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return data
    }
}

