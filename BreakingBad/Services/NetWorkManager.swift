//
//  NetWorkManager.swift
//  BreakingBad
//
//  Created by Karen Tsarukian on 17.05.2022.
//
import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let linkURL = "https://www.breakingbadapi.com/api/characters"

    private init() {}
    
    func fetch(from url: String, with completion: @escaping ([Character]) -> Void) {
        AF.request(url)
            .responseJSON { dataResponse in
                guard let statusCode = dataResponse.response?.statusCode else { return }
                
                if (200..<300).contains(statusCode) {
                    guard let value = dataResponse.value else { return }
                    let characters = Character.getCharacters(from: value)
                    DispatchQueue.main.async {
                        completion(characters)
                    }
                } else {
                    guard let error = dataResponse.error else { return }
                    print(error)
                }
            }
    }
    
//    func fetch(from url: String, with completion: @escaping (Result<[Character], NetworkError>) -> Void) {
//        guard let url = URL(string: url) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let character = try JSONDecoder().decode([Character].self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(character))
//                }
//            } catch let error {
//                completion(.failure(.decodingError))
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
}
