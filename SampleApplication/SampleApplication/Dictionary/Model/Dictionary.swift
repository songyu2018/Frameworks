/*
 Generated by: https://app.quicktype.io/#l=swift
        Make sure select "Make all properties optional"
 */

import Foundation

struct Dictionary: Codable {
    let metadata: Metadata?
    let results: [Result]?
    
    enum CodingKeys: String, CodingKey {
        case metadata = "metadata"
        case results = "results"
    }
}

struct Metadata: Codable {
    let provider: String?
    
    enum CodingKeys: String, CodingKey {
        case provider = "provider"
    }
}

struct Result: Codable {
    let id: String?
    let language: String?
    let lexicalEntries: [LexicalEntry]?
    let type: String?
    let word: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case language = "language"
        case lexicalEntries = "lexicalEntries"
        case type = "type"
        case word = "word"
    }
}

struct LexicalEntry: Codable {
    let entries: [Entry]?
    let language: String?
    let lexicalCategory: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case entries = "entries"
        case language = "language"
        case lexicalCategory = "lexicalCategory"
        case text = "text"
    }
}

struct Entry: Codable {
    let grammaticalFeatures: [GrammaticalFeature]?
    let homographNumber: String?
    let senses: [Sense]?
    
    enum CodingKeys: String, CodingKey {
        case grammaticalFeatures = "grammaticalFeatures"
        case homographNumber = "homographNumber"
        case senses = "senses"
    }
}

struct GrammaticalFeature: Codable {
    let text: String?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
    }
}

struct Sense: Codable {
    let definitions: [String]?
    let id: String?
    let translations: [Translation]?
    let examples: [Example]?
    
    enum CodingKeys: String, CodingKey {
        case definitions = "definitions"
        case id = "id"
        case translations = "translations"
        case examples = "examples"
    }
}

struct Example: Codable {
    let text: String?
    let translations: [Translation]?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case translations = "translations"
    }
}

struct Translation: Codable {
    let language: Language?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case text = "text"
    }
}

enum Language: String, Codable {
    case tn = "tn"
}
