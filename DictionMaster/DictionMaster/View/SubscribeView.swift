//
//  SubscribeView.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 08/02/24.
//

import SwiftUI

struct SubscribeView: View {
    var body: some View {
        VStack {
            Image("woman")
            VStack {
                Image("icon")
                    .frame(height: 35)
                Image("title")
                    .padding(.leading, 40)
            }
            .padding(.top, -25)
            
            VStack {
                VStack {
                    Text("Subscribe now to get ")
                        .foregroundColor(Color("#052D39"))
                    + Text(verbatim: "unlimited ")
                        .foregroundColor(Color("#5BD6FD"))
                    + Text(verbatim: "searches and full access ")
                        .foregroundColor(Color("#052D39"))
                    + Text(verbatim: "to all features.")
                        .foregroundColor(Color("#5BD6FD"))
                }
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            }
            .padding(.top, -10)
            
            Spacer(minLength: 40)
            
            VStack {
                Text("Try 7 Days Free")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                + Text(verbatim: ", then only ")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                + Text(verbatim: "$19,99 ")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                + Text(verbatim: "per year. Cancel anytime.")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
            }
            .foregroundColor(Color("#052D39"))
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Button(action: {
                
            }) {
                Text("SUBSCRIBE")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.white)
                    .frame(width: 358, height: 64)
                    .background(Color("#5BD6FD"))
                    .cornerRadius(14)
            }
            .padding(.bottom, 20)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SubscribeView()
}
