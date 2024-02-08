//
//  WordModel.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 07/02/24.
//

import Foundation

struct WordInfo: Codable {
    let word: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
}

struct Phonetic: Codable {
    let text: String?
    let audio: String
}

struct Meaning: Codable {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: [String]
    let antonyms: [String]
}

struct Definition: Codable {
    let definition: String
    let synonyms: [String]
    let antonyms: [String]
    let example: String?
}
