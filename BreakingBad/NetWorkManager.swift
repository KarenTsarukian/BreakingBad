//
//  NetWorkManager.swift
//  BreakingBad
//
//  Created by Karen Tsarukian on 17.05.2022.
//
import Foundation

class NetWorkManager {
    static let shared = NetWorkManager()
    
    func fetch(from url: String, with completion: @escaping ([Character]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let character = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    completion(character)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    init() {}
}
