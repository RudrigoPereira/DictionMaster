//
//  WordModel.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 07/02/24.
//

import Foundation

struct WordInfo {
    let word: String
    let phonetics: [Phonetic]
    let meanings: [Meaning]
    let license: License
    let sourceUrls: [String]
}

struct Phonetic {
    let text: String?
    let audio: String
    let sourceUrl: String
    let license: License
}

struct Meaning {
    let partOfSpeech: String
    let definitions: [Definition]
    let synonyms: [String]
    let antonyms: [String]
}

struct License {
    let name: String
    let url: String
}

struct Definition {
    let definition: String
    let synonyms: [String]
    let antonyms: [String]
    let example: String?
}
