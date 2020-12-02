//
//  DataResponse.swift
//  WP Quizzes
//
//  Created by Yuliia Olikhovska on 02/12/2020.
//

import Foundation

// MARK: - Quizzes
struct Quizzes: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let questions: Int
    let createdAt: String
    let sponsored: Bool
    let title: String
    let type: String
    let content, buttonStart, shareTitle: String
    let categories: [Categories]
    let id: Int
    let mainPhoto: MainPhoto
    let category: Category
    let publishedAt: String
    let productUrls: ProductUrls
    let tags: [Tag]?
    let flagResults: [FlagResult]?
}

// MARK: - Categories
struct Categories: Codable {
    let uid: Int
    let secondaryCid: String?
    let name: String
    let type: String
    let primary: Bool?
}

//MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
}

//MARK - MainPhoto
struct MainPhoto: Codable {
    let author: String
    let width: Int
    let source: String
    let title: String
    let url: String
    let height: Int
}

// MARK: - ProductUrls
struct ProductUrls: Codable {
    let the5888315728036481: String
    
    enum CodingKeys: String, CodingKey {
        case the5888315728036481 = "5888315728036481"
    }
}

//MARK - Tag
struct Tag: Codable {
    let uid: Int
    let name: String
    let type: String
    let primary: Bool
}
//MARK - FlagResult
struct FlagResult: Codable {
    let image: Image
    let flag: String
    let title: String
    let content: String
}

//MARK - Image
struct Image: Codable {
    let author, source, url: String
    let height, width: String
}
