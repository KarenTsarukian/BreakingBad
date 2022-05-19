//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by Karen Tsarukian on 16.05.2022.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    let linkURL = "https://www.breakingbadapi.com/api/characters"
    
    private var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        tableView.backgroundColor = .black
        
        fetchData(from: linkURL)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
        
//        var content = cell.defaultContentConfiguration()
//        content.imageProperties.cornerRadius = tableView.rowHeight / 2
//        cell.contentConfiguration = content
                
        return cell
    }
}

extension CharactersViewController {
    private func fetchData(from url: String) {
        NetWorkManager.shared.fetch(from: url) { character in
            self.characters = character
            self.tableView.reloadData()
        }
    }
}
