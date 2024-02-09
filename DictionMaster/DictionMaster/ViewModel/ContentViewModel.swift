//
//  ContentViewModel.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 09/02/24.
//

import Foundation

class WordViewModel: ObservableObject {
    @Published var wordInput: String = ""
    @Published var isButtonVisible: Bool = false
    @Published var isShowingResult = false
    @Published var wordInfo: WordInfo?
    @Published var showSubscribeView: Bool = false
    
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
        if Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: lastSearchDate)) && searchCount >= 5 {
            print("Limite de pesquisa diária atingido")
            showSubscribeView = true
            return
        }
        
        if !Calendar.current.isDateInToday(Date(timeIntervalSinceReferenceDate: lastSearchDate)) {
            searchCount = 0
            lastSearchDate = currentDate.timeIntervalSinceReferenceDate
        }
        
        searchCount += 1
        fetchWordInfo()
    }
    
    private func fetchWordInfo() {
        let apiService = DictionaryAPI()
        
        apiService.fetchWordInfo(for: wordInput) { result in
            switch result {
            case .success(let wordInfo):
                print(wordInfo)
                self.wordInfo = wordInfo
                self.isShowingResult = true
            case .failure(let error):
                print("Erro ao obter informações da palavra: \(error)")
            }
        }
    }
    
    func updateButtonVisibility() {
        isButtonVisible = !wordInput.isEmpty
    }
}
