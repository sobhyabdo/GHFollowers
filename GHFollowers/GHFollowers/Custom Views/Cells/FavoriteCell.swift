//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/24/21.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuesdID = "FavoriteCell"
    
    let avaterImageView = GHAvaterIamgeView(frame: .zero)
    let userNameLabel = GHTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setName(favorite: Follower) {
        userNameLabel.text = favorite.login
        avaterImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avaterImageView)
        addSubview(userNameLabel)
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            avaterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avaterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avaterImageView.heightAnchor.constraint(equalToConstant: 60),
            avaterImageView.widthAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: 24),
            userNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 40)
        
        
        ])
    }
    
}
