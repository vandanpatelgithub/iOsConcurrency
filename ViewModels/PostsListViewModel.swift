//
//  PostsListViewModel.swift
//  iOSConcurrency (iOS)
//
//  Created by Vandankumar Patel on 1/2/22.
//

import Foundation

final class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    var userId: Int?
    
    func fetchPosts() {
        if let userId = userId {
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            apiService.getJSON { (result: Result<[Post], APIError>) in
                switch result {
                case let .success(posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case let .failure(error):
                    print(error)
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
