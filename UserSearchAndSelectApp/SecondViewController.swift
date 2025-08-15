//
//  SecondViewController.swift
//  UserSearchAndSelectApp
//
//  Created by YoonieMac on 7/22/25.
//

import UIKit

class SecondViewController: UIViewController {
    
    var service = UserAPIServiceSimulator.shared
    var filteredUsers: [User] = []
    var activityIndicator = UIActivityIndicatorView()
    
    let searchBar: UISearchBar = {
        let sbar = UISearchBar()
        sbar.placeholder = "사용자 이름 검색"
        sbar.keyboardType = .emailAddress
        sbar.backgroundColor = .secondarySystemBackground
        sbar.autocapitalizationType = .none
        sbar.autocorrectionType = .no
        sbar.enablesReturnKeyAutomatically = true
        sbar.keyboardAppearance = .dark
        sbar.spellCheckingType = .no
        sbar.showsSearchResultsButton = true
        return sbar
    }()
    
    let userTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .systemBackground
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var onNameChanged: ((User) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        setAutoLayout()
    }
    
    func setup() {
        view.backgroundColor = .white
        userTableView.dataSource = self
        userTableView.delegate = self
        searchBar.delegate = self
        userTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        activityIndicator.center = view.center
        
        view.addSubview(userTableView)
        view.addSubview(activityIndicator)
        navigationItem.titleView = searchBar
        
        search(keyword: "")
    }
    
    func setAutoLayout() {
        
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            userTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            userTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
        ])
    }
    
    func search(keyword: String) {
        activityIndicator.startAnimating()
        
        service.searchUsers(keyword: keyword) { [weak self] users in
            guard let self else {return}
            self.filteredUsers = users
            self.userTableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
}


extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let target = self.filteredUsers[indexPath.row]
        cell.textLabel?.text = target.name
        return cell
    }
    
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = filteredUsers[indexPath.row]
        self.onNameChanged?(selectedUser)
        navigationController?.popViewController(animated: true)
    }
}

extension SecondViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.search(keyword: searchText)
    }
}


