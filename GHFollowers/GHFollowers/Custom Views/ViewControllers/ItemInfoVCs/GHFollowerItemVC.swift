//
//  GHFollowerItemVC.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/11/21.
//

import UIKit

class GHFollowerItemVC: GHItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .Following, withCount: user.following)
        
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTaped() {
        
        guard user.followers != 0 else {
            presentGHAlertOnMainThread(title: "No Followers!", message: "that user has no Followers.", buttonTitle: "Ok")
            return
        }
        
        delegate.didTapGetFollowers(for: user)
    }
}
