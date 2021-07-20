//
//  ViewController.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {
    let myProfile = Person.generateMyProfile()
    let friends = Person.generateFriend()
    
    private let tableView: UITableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        settingView()
    }
    
    //    MARK:- SettingView + Constraint
    func settingView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MyProfileTableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
        ])
    }
}

// MARK:- TableViewExtension (DataSource, Delegate)
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
//            case: My Profile Count
            return 1
        } else {
//            case: Friend Count (How Many)
            return friends.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        My Profile Section: 0, Friend Section: 1 -> Total: 2
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "My Profile"
        } else if section == 1 {
            return " "
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return CGFloat(1)
        } else {
            return CGFloat(20)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! MyProfileTableViewCell
            let target = myProfile
            cell.textLabel?.text = target.name.text
            cell.imageView?.image = target.profile?.image
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! FriendTableViewCell
            let target = friends[indexPath.row]
            cell.textLabel?.text = target.name.text
            cell.imageView?.image = target.profile?.image
            return cell
        }
        return UITableViewCell()
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        tableView.headerView(forSection: 0)?.tintColor = .white
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let myProfileVC = MyProfileViewController()
            myProfileVC.modalPresentationStyle = .fullScreen
            present(myProfileVC, animated: true, completion: nil)
        }
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        print("Cell Selected: ", #function)
        cell.setSelected(false, animated: true)
        
    }
}
