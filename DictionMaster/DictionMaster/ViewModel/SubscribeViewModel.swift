//
//  SubscribeViewModel.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 09/02/24.
//

import Foundation
import SwiftUI

class SubscribeViewModel: ObservableObject {
    let appStoreURL = URL(string: "https://apps.apple.com/br/app/falou-o-melhor-app-de-ingl%C3%AAs/id1460579936")!
    
    func openAppStore() {
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL)
        }
    }
}
