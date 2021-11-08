//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 6/22/21.
//

import UIKit

class FollowerCell: UICollectionViewCell {
   
    static let reuesdID = "FollowerCell"
    
    let avaterImageView = GHAvaterIamgeView(frame: .zero)
    let userNameLabel = GHTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setName(follower: Follower) {
        userNameLabel.text = follower.login
        avaterImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        
        let padding: CGFloat = 8
        
        addSubview(avaterImageView)
        addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            avaterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avaterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avaterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avaterImageView.heightAnchor.constraint(equalTo: avaterImageView.widthAnchor),
            
            
            userNameLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: 12),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
}
