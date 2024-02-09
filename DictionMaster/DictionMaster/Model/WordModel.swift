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

struct Meaning: Codable, Hashable {
    let partOfSpeech: String
    let definitions: [Definition]
}

struct Definition: Codable, Hashable {
    let definition: String
    let example: String?
}
