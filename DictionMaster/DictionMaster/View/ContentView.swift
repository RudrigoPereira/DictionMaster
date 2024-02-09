//
//  ContentView.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 06/02/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var wordInput: String = ""
    @State private var isButtonVisible: Bool = false
    @State private var isShowingResult = false
    @State private var wordInfo: WordInfo?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("flag")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26, height: 26)
                    
                    Text("ENGLISH")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundColor(Color("#052D39"))
                }
                .frame(width: 137, height: 40)
                .background(Color("#91A9B1").opacity(0.1))
                .cornerRadius(20)
                .padding(.top, 40)
                
                Spacer()
                
                TextField(
                    "",
                    text: $wordInput,
                    prompt: Text("Type a word...")
                        .font(.system(size: 32, weight: .regular, design: .rounded))
                        .foregroundColor(Color("#052D39").opacity(0.5))
                )
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(Color("#052D39"))
                .multilineTextAlignment(.center)
                .padding(.bottom, isButtonVisible ? 25 : 75)
                
                Spacer()
                
//                NavigationLink(destination: wordInfo.map { WordResultView(wordInfo: $0) }.navigationBarBackButtonHidden(true) , isActive: $isShowingResult) {
//                    EmptyView()
//                }
//                .hidden()
                
                NavigationLink(destination: wordInfo.map { WordResultView(wordInfo: $0, wordInput: $wordInput) }.navigationBarBackButtonHidden(true) , isActive: $isShowingResult) {
                    EmptyView()
                }
                .hidden()
                
                if isButtonVisible {
                    Button(action: {
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
                    }) {
                        Text("SEARCH")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color.white)
                            .frame(width: 358, height: 64)
                            .background(Color("#5BD6FD"))
                            .cornerRadius(14)
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color.white)
            .onReceive(Just(wordInput)) { input in
                isButtonVisible = !input.isEmpty
            }
        }
    }
}

#Preview {
    ContentView()
}
