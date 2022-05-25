//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Karen Tsarukian on 16.05.2022.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var portrayedLabel: UILabel!
    @IBOutlet var photoView: UIImageView! {
        didSet {
            photoView.clipsToBounds = true
            photoView.layer.cornerRadius = photoView.frame.height / 2
        }
    }
    
    func configure (with character: Character) {
        nameLabel.text = "Name: \(character.name)"
        birthdayLabel.text = "Birthday: \(character.birthday)"
        nicknameLabel.text = "Nickname: \(character.nickname)"
        portrayedLabel.text = "Portrayed: \(character.portrayed)"
        
        DispatchQueue.global().async {
            guard let url = URL(string: character.img) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.photoView.image = UIImage(data: imageData)
            }
        }
    }
}
