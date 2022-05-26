//
//  Character.swift
//  BreakingBad
//
//  Created by Karen Tsarukian on 16.05.2022.
//

import Combine

struct Character: Decodable {
    let name: String
    let birthday: String
    let img: String
    let nickname: String
    let portrayed: String
    
    init(characterData: [String: Any]) {
        name = characterData["name"] as? String ?? ""
        birthday = characterData["birthday"] as? String ?? ""
        img = characterData["img"] as? String ?? ""
        nickname = characterData["nickname"] as? String ?? ""
        portrayed = characterData["portrayed"] as? String ?? ""
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.compactMap { Character.init(characterData: $0)}
    }
}
