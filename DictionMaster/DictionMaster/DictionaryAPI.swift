//
//  DictionaryAPI.swift
//  DictionMaster
//
//  Created by Rodrigo Ferreira Pereira on 08/02/24.
//

import Foundation

class DictionaryAPI {
    func fetchWordInfo(for word: String, completion: @escaping (Result<WordInfo, Error>) -> Void) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Server Error", code: 0, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            print(url)
            
            do {
                let decoder = JSONDecoder()
                let wordInfo = try decoder.decode([WordInfo].self, from: data)
                guard let firstWordInfo = wordInfo.first else {
                    completion(.failure(NSError(domain: "No word info found", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(firstWordInfo))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

