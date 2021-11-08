//
//  GHReposItemView.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/11/21.
//

import UIKit

class GHReposItemView: GHItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}
