//
//  userInfoVC.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/3/21.
//

import UIKit

protocol UserInfoVCDelegate: class {
    
    func didTapGitHubProfile(for user: User)
    
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    var username: String!
    var itemViews: [UIView] = []
    
    weak var delegate: FollowerListVCDelegate!                                      // here this vc will talking to FollowerListVc to make action

    let headerView = UIView()
    let itemOne = UIView()
    let itemTwo = UIView()
    let dateLabel = GHBodyLabel(textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        configureVC()
        getUserInfo()

    }
    
    func configureVC() {
        
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissmissUserInfo))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        
        NetworkManager.shered.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElement(with: user)
                }
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "something went be wrong", message: error.rawValue, buttonTitle: "ok")
            }
        }
    }
    
    
    func configureUIElement(with user: User) {
        
        let reposItemVC = GHReposItemVC(user: user)
        reposItemVC.delegate = self
        
        let followerItemVC = GHFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: reposItemVC, to: self.itemOne)
        self.add(childVC: followerItemVC, to: self.itemTwo)
        self.add(childVC: GHUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = " GitHub since \(user.createdAt.convertToDisplayFormat())"
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemOne, itemTwo, dateLabel]

        for itemview in itemViews {
            view.addSubview(itemview)
            itemview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemTwo.topAnchor.constraint(equalTo: itemOne.bottomAnchor, constant: padding),
            itemTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dissmissUserInfo() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        // Show Safari VC
        guard let url = URL(string: user.htmlUrl) else {
            presentGHAlertOnMainThread(title: "invalid URL", message: "url of user is wrong!", buttonTitle: "ok")
            return
        }
        presentSafari(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        // dismiss VC
        // tell follower list followers of new user
        delegate.didRequestFollowers(for: user.login)
        dissmissUserInfo()
        
    }
    
    
}
