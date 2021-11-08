//
//  GHUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/5/21.
//

import UIKit

class GHUserInfoHeaderVC: UIViewController {
    
    var user: User!

    let avaterImageView = GHAvaterIamgeView(frame: .zero)
    let usernameLabel = GHTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GHSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GHSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GHBodyLabel(textAlignment: .left)
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubview()
        layoutUI()
        configureUIElements()
        
    }
    
    func configureUIElements() {
        avaterImageView.downloadImage(from: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name ?? ""
        locationImageView.image = UIImage(systemName: SFSymbols.Location)
        locationImageView.tintColor = .secondaryLabel
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No Bio available"
        bioLabel.numberOfLines = 3
    }
    
    func addSubview() {
        view.addSubview(avaterImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            avaterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avaterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avaterImageView.widthAnchor.constraint(equalToConstant: 90),
            avaterImageView.heightAnchor.constraint(equalToConstant: 90),
            
            usernameLabel.topAnchor.constraint(equalTo: avaterImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.centerYAnchor.constraint(equalTo: avaterImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avaterImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avaterImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: textImagePadding),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avaterImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avaterImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

}
