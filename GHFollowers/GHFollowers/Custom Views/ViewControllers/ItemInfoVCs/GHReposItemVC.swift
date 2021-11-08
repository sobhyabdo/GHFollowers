//
//  GHReposItemVC.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/11/21.
//

import UIKit

class GHReposItemVC: GHItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTaped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
