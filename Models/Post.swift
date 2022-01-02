//
//  Post.swift
//  iOSConcurrency (iOS)
//
//  Created by Vandankumar Patel on 12/29/21.
//

import Foundation

struct Post: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
