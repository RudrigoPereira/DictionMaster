//
//  LaunchScreen.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 06/02/24.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    VStack {
                        Image("icon")
                            .frame(height: 35)
                        Image("title")
                            .padding(.leading, 40)
                    }
                    .padding(.bottom, 100)
                    Spacer()
                    Text("by Rodrigo Ferreira Pereira")
                        .font(Font.custom("SF Pro Rounded Regular", size: 22))
                        .padding(.bottom, 20)
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                    
                }
            }
        }
    }
}

#Preview {
    LaunchScreen()
}
