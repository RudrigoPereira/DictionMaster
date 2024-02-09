//
//  ContentViewModel.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 09/02/24.
//

import Foundation

class ContentViewModel: ObservableObject {
    @Published var wordInput: String = ""
    @Published var isButtonVisible: Bool = false
    @Published var isShowingResult = false
    @Published var wordInfo: WordInfo?
    @Published var showSubscribeView: Bool = false
    
    private var searchCache: [String: WordInfo] {
        get {
            if let data = UserDefaults.standard.data(forKey: "searchCache"),
               let cache = try? JSONDecoder().decode([String: WordInfo].self, from: data) {
                return cache
            } else {
                return [:]
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "searchCache")
            }
        }
    }
    
    var searchCount: Int {
        get { UserDefaults.standard.integer(forKey: "searchCount") }
        set { UserDefaults.standard.set(newValue, forKey: "searchCount") }
    }
    
    var lastSearchDate: TimeInterval {
        get { UserDefaults.standard.double(forKey: "lastSearchDate") }
        set { UserDefaults.standard.set(newValue, forKey: "lastSearchDate") }
    }
    
    func searchWord() {
        let currentDate = Date()

        if !Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: lastSearchDate)) {
            searchCount = 0
            lastSearchDate = currentDate.timeIntervalSinceReferenceDate
        }

        if let cachedWordInfo = searchCache[wordInput] {
            wordInfo = cachedWordInfo
            isShowingResult = true
        } else {
            if Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: lastSearchDate)) && searchCount >= 5 {
                showSubscribeView = true
                return
            } else {
                fetchWordInfo()
            }
        }
    }

    private func fetchWordInfo() {
        searchCount += 1

        let apiService = DictionaryAPI()
        
        apiService.fetchWordInfo(for: wordInput) { result in
            switch result {
            case .success(let wordInfo):
                self.wordInfo = wordInfo
                self.isShowingResult = true
                self.searchCache[self.wordInput] = wordInfo
            case .failure(let error):
                print("Erro ao obter informações da palavra: \(error)")
            }
        }
    }
    
    func updateButtonVisibility() {
        isButtonVisible = !wordInput.isEmpty
    }
}
