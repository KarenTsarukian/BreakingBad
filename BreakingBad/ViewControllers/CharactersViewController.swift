//
//  CharactersViewController.swift
//  BreakingBad
//
//  Created by Karen Tsarukian on 16.05.2022.
//

import UIKit

class CharactersViewController: UITableViewController {
    
    private var characters: [Character] = []
    private var spinnerView: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
        
        spinnerView = showSpinner(in: tableView)
        
        fetch(from: NetworkManager.shared.linkURL)
//        fetchData(from: NetWorkManager.shared.linkURL)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.configure(with: character)
      
        return cell
    }
    
    private func showSpinner (in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    private func fetch(from url: String) {
        NetworkManager.shared.fetch(from: url) { characters in
            self.characters = characters
            self.tableView.reloadData()
            self.spinnerView?.stopAnimating()
        }
    }
}

//extension CharactersViewController {
//    private func fetchData(from url: String) {
//        NetWorkManager.shared.fetch(from: url) { character in
//            switch character {
//            case .success(let character):
//                self.characters = character
//                self.tableView.reloadData()
//                self.spinnerView?.stopAnimating()
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//}
