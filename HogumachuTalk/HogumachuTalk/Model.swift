//
//  Model.swift
//  HogumachuTalk
//
//  Created by 홍성준 on 2021/07/08.
//

import UIKit


struct Person {
    let name: UILabel
    let profile: UIImageView?
    static func generateFriend() -> [Person] {
        let name: [String] = ["가", "가", "가", "가", "가", "가", "가", "가",
                              "나", "나", "나", "나", "나", "나", "나", "나",
                              "다", "다", "다", "다", "다", "다", "다", "다",
                              "라", "라", "라", "라", "라", "라", "라", "라",
                              "마", "마", "마", "마", "마", "마", "마", "마",
                              "바", "바", "바", "바", "바", "바", "바", "바"]
        let profile: [UIImage?] = [UIImage(systemName: "person"), UIImage(systemName: "person.fill.xmark"), UIImage(systemName: "person.fill.questionmark"), UIImage(systemName: "person.circle")]
        
        var friends = [Person]()
        
        for i in 0..<name.count {
            
            let myLabel = UILabel()
            myLabel.text = name[i]
            myLabel.font = .systemFont(ofSize: 15)
            myLabel.textColor = .black
            let myImageView = UIImageView()
            myImageView.image = profile[0]
            let friend = Person(name: myLabel, profile: myImageView)
            friends.append(friend)
        }
        return friends
    }

    static func generateMyProfile() -> Person {
        let myLabel = UILabel()
        myLabel.text = "Hogumachu"
        myLabel.font = .systemFont(ofSize: 15)
        myLabel.textColor = .black
        let myImageView = UIImageView()
        myImageView.image = UIImage(systemName: "person.fill")
        let me = Person(name: myLabel, profile: myImageView)
        return me
    }
    
}




