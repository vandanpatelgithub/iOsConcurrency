//
//  PostsListViewModel.swift
//  iOSConcurrency (iOS)
//
//  Created by Vandankumar Patel on 1/2/22.
//

import Foundation

final class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    var userId: Int?
    
    func fetchPosts() {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            isLoading.toggle()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                apiService.getJSON { (result: Result<[Post], APIError>) in
                    defer {
                        DispatchQueue.main.async {
                            self.isLoading.toggle()
                        }
                    }
                    
                    switch result {
                    case let .success(posts):
                        DispatchQueue.main.async {
                            self.posts = posts
                        }
                    case let .failure(error):
                        DispatchQueue.main.async {
                            self.showAlert = true
                            self.errorMessage = error.localizedDescription
                        }
                    }
                }
            }
        }
    }
}

extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUsersPostArray
        }
    }
}
