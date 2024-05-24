//
//  NetworkManager.swift
//  MixingColors
//
//  Created by Natalia on 23.05.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func getNameOfColor(withComponents components: String, completion: @escaping (String) -> Void) {
        let urlString = createUrl(with: components)
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let color = try JSONDecoder().decode(Color.self, from: data)
                completion(color.name.value)
            } catch let error {
                print(error)
            }
        }
        .resume()
    }
    
    private func createUrl(with components: String) -> String {
        "https://www.thecolorapi.com/id?rgb=\(components)"
    }
}
