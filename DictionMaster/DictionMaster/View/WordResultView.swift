//
//  WordResultView.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 08/02/24.
//

import SwiftUI

struct WordResultView: View {
    let wordInfo: WordInfo
    @StateObject private var viewModel: WordResultViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var wordInput: String
    @State private var isSpeakerPressed = false
    
    init(wordInfo: WordInfo, wordInput: Binding<String>) {
        self.wordInfo = wordInfo
        self._wordInput = wordInput
        self._viewModel = StateObject(wrappedValue: WordResultViewModel(wordInfo: wordInfo))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text(wordInfo.word)
                        .font(.system(size: 45, weight: .bold, design: .rounded))
                        .foregroundColor(Color("#052D39"))
                    Spacer()
                }
                .padding(.bottom, 1)
                
                HStack {
                    Circle()
                        .foregroundColor(Color("#5BD6FD"))
                        .opacity(isSpeakerPressed ? 0.5 : 1.0)
                        .frame(width: 46, height: 46)
                        .overlay(
                            Image(systemName: "speaker.wave.2.fill")
                                .foregroundColor(.white)
                        )
                        .onTapGesture {
                            isSpeakerPressed.toggle()
                            viewModel.playAudio()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                withAnimation {
                                    isSpeakerPressed = false
                                }
                            }
                        }
                    
                    Text(viewModel.firstNonEmptyPhoneticText() ?? "")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(Color("#052D39").opacity(0.4))
                    Spacer()
                }
                
                VStack(alignment: .leading, spacing: 40) {
                    ForEach(wordInfo.meanings.indices, id: \.self) { index in
                        let meaning = wordInfo.meanings[index]
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                if let firstDefinition = meaning.definitions.first {
                                    Text("\(index + 1)) ")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("#052D39"))
                                    + Text("[\(meaning.partOfSpeech)] ")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("#052D39").opacity(0.5))
                                    + Text("\(firstDefinition.definition)")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .foregroundColor(Color("#052D39"))
                                }
                            }
                            .padding(.bottom, 15)
                            
                            ForEach(meaning.definitions.dropFirst(), id: \.self) { definition in
                                Text("• \(definition.definition)")
                                    .font(.system(size: 16, weight: .regular, design: .rounded))
                                    .foregroundColor(Color("#052D39"))
                                    .padding(.bottom, -5)
                            }
                        }
                    }
                }
                .padding(.top, 10)
                Spacer(minLength: 50)
            }
            .padding(.horizontal, 20)
            
            Divider()
            VStack {
                HStack {
                    Text("That’s it for “\(wordInfo.word)”!")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(Color("#052D39"))
                    Spacer()
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Try another search now!")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundColor(Color("#052D39"))
                    Spacer()
                }
                .padding(.top, 1)
                
                
                Button(action: {
                    DispatchQueue.main.async {
                        self.wordInput = ""
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("NEW SEARCH")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                        .frame(width: 358, height: 64)
                        .background(Color("#5BD6FD"))
                        .cornerRadius(14)
                }
                .padding(.top, 20)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.white)
    }
}

#Preview {
    let previewWordInfo = WordInfo(word: "", phonetics: [], meanings: [])
    return WordResultView(wordInfo: previewWordInfo, wordInput: .constant(""))
}
