//
//  ContentView.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 06/02/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
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
                    text: $viewModel.wordInput,
                    prompt: Text("Type a word...")
                        .font(.system(size: 32, weight: .regular, design: .rounded))
                        .foregroundColor(Color("#052D39").opacity(0.5))
                )
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundColor(Color("#052D39"))
                .multilineTextAlignment(.center)
                .padding(.bottom, viewModel.isButtonVisible ? 25 : 75)
                .onChange(of: viewModel.wordInput) { _ in
                    viewModel.updateButtonVisibility()
                }
                
                Spacer()
                
                NavigationLink(destination: viewModel.wordInfo.map { WordResultView(wordInfo: $0, wordInput: $viewModel.wordInput) }.navigationBarBackButtonHidden(true) , isActive: $viewModel.isShowingResult) {
                    EmptyView()
                }
                .hidden()
                
                NavigationLink(destination: SubscribeView().navigationBarBackButtonHidden(true), isActive: $viewModel.showSubscribeView) {
                    EmptyView()
                }
                .hidden()
                
                if viewModel.isButtonVisible {
                    Button(action: {
                        viewModel.searchWord()
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
        }
    }
}

#Preview {
    ContentView()
}
