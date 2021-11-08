//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 4/3/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImage = UIImageView()
    let userNameTextFiled = GHTextField()
    let pressedButton = GHButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
        
    var isUserNameEntered: Bool { return !userNameTextFiled.text!.isEmpty }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureTextField()
        configurePressedButton()
        dismissKeyboardTapGesture()
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextFiled.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func dismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)) )
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        
        guard isUserNameEntered else {
            presentGHAlertOnMainThread(title: "Empty username", message: "please enter username to be able to search", buttonTitle: "ok")
            return
        }
        
        userNameTextFiled.resignFirstResponder()
        
        let followerListVC = FollowerListVC(username: userNameTextFiled.text!)
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zommed ? 20 : 80
        logoImageViewTopConstraint = logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        
        view.addSubview(userNameTextFiled)
        userNameTextFiled.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextFiled.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            userNameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextFiled.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    
    func configurePressedButton() {
        
        view.addSubview(pressedButton)
        pressedButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            pressedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            pressedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            pressedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            pressedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        pushFollowerListVC()
        
        return true
    }
    
    
}
