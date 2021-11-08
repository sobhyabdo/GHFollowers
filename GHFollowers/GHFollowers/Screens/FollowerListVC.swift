//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 4/11/21.
//

import UIKit

protocol FollowerListVCDelegate: class {
    
    func didRequestFollowers(for username: String)
}

class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName: String!
    var followers: [Follower] = []
    var page = 1
    var filterFollowers: [Follower] = []
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSocure: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: userName, page: page)
        configureDataSource()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.collectionThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuesdID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        NetworkManager.shered.getFollowers(for: userName, page: page) { [ weak self ] result in
            guard let self = self else { return }                   // here i make a guard to make self is unwrapping to make actuaily have it
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count > 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "this is user dosn't have followers, you can follow him 😁."
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
            

        }
    }
    
    func configureDataSource() {
        dataSocure = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuesdID, for: indexPath) as! FollowerCell
            cell.setName(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSocure.apply(snapShot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        
        showLoadingView()
        
        NetworkManager.shered.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    
                    guard let error = error else {
                        self.presentGHAlertOnMainThread(title: "Success!", message: "You had added \(self.userName!) 🎉 for your favorites", buttonTitle: "OK")
                        return
                    }
                    self.presentGHAlertOnMainThread(title: "something is wrong with save user!", message: error.rawValue, buttonTitle: "ok")
                }
            case .failure(let error):
                self.presentGHAlertOnMainThread(title: "Something me be wrong!", message: error.rawValue, buttonTitle: "ok")
            }
        }
        
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offSetY = scrollView.contentOffset.y                            // "How far your Scroll"
        let contentHeight = scrollView.contentSize.height                   // height of size content in scroll which is 3000 followers
        let height = scrollView.frame.size.height                           // height of screen size on eny iphone
    
        if offSetY > contentHeight - height {                               // here i hit to bottom to see what next!
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activeArray = isSearching ? filterFollowers : followers
        
        let followerSelect = activeArray[indexPath.item]
        
        let destUserInfo = UserInfoVC()
        destUserInfo.username = followerSelect.login
        destUserInfo.delegate = self                                                            // it make followeLictVC to listen to userInfoVC
        let navController = UINavigationController(rootViewController: destUserInfo)
        
        present(navController, animated: true)
            
        }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        
        filterFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        // "$0" mean to followers arrary it had a logain and dosn't matter is a lower case to comersion with my filter and so on dosn't matter is a lower case
        
        updateData(on: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        // get follower for that user!
        
        self.userName = username
        title = username
        page = 1
        
        followers.removeAll()
        filterFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        
        getFollowers(username: username, page: page)
        
    }
}
