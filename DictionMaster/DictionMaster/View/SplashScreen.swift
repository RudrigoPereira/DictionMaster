//
//  LaunchScreen.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 06/02/24.
//

import SwiftUI

struct SplashScreen: View {
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
                        .font(.system(size: 22, weight: .regular, design: .rounded))
                        .foregroundColor(Color("#052D39"))
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
    SplashScreen()
}
