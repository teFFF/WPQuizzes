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
    let width: Text
    let source: String
    let title: String?
    let url: String
    let height: Text
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
    let height, width: Text
    let mediaId: String?
}

//MARK: - Quiz
struct Quiz: Codable {
    let celebrity: Celebrity
    let opinionsEnabled: Bool
    let rates: [Rate]
    let questions: [Question]
    let createdAt: String
    let sponsored: Bool
    let title: String
    let type: String
    let content: String
    let buttonStart: String
    let tags: [Tag]?
    let shareTitle: String
    let flagResults: [FlagResult]?
    let categories: [Categories]
    let id: Int
    let scripts: String
    let mainPhoto: MainPhoto
    let category: Category
    let isBattle: Bool
    let created: Int
    let canonical: String
    let productUrl: String
    let publishedAt: String
    let latestResults: [LatestResult]
    let avgResult: Double
    let resultCount: Int
    let cityAvg, cityTime, cityCount: String?
    let userBattleDone: Bool
    let sponsoredResults: SponsoredResults
    
    enum CodingKeys: String, CodingKey {
        case celebrity
        case opinionsEnabled = "opinions_enabled"
        case rates, questions, createdAt, sponsored, title, type, content, buttonStart, tags, shareTitle, flagResults, categories, id, scripts, mainPhoto, category, isBattle, created, canonical, productUrl, publishedAt, latestResults, avgResult, resultCount, cityAvg, cityTime, cityCount, userBattleDone, sponsoredResults
    }
}

// MARK: - Celebrity
struct Celebrity: Codable {
    let result, imageAuthor, imageHeight, imageUrl: String
    let show: Int
    let name, imageTitle, imageWidth, content: String
    let imageSource: String
}

// MARK: - Rate
struct Rate: Codable {
    let from, to: Int
    let content: String
}

// MARK: - Question
struct Question: Codable {
    let image: MainPhoto
    let answers: [Answer]
    let text: String
    let answer: String
    let type: String
    let order: Int
}

// MARK: - AnswerElement
struct Answer: Codable {
    let image: Image
    let order: Int
    let text: String
    var isCorrect: Int? = 0
}

// MARK: - LatestResult
struct LatestResult: Codable {
    let city: Int
    let endDate: String
    let result: Double
    let resolveTime: Int
    
    enum CodingKeys: String, CodingKey {
        case city
        case endDate = "end_date"
        case result, resolveTime
    }
}

// MARK: - SponsoredResults
struct SponsoredResults: Codable {
    let imageAuthor, imageHeight, imageUrl, imageWidth: String
    let textColor, content, mainColor, imageSource: String
}

enum Text: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Text.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Text"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
