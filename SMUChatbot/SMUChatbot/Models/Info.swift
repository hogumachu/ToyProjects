import UIKit

struct Info {
    let title: String
    let detailInfo: String
    let color: UIColor
    let detailView: UIView
}

let myChatbotInfo = [
//    Info(title: "Chatbot", detailInfo: "챗봇이란", color: .systemPink, detailView: UIView()),
    Info(title: "Team ChattingHaeJo", detailInfo: "채팅해조 팀이란", color: .darkGray, detailView: teamChattingHaeJoView()),
    Info(title: "How to use", detailInfo: "채팅해조 챗봇 사용법", color: .systemIndigo, detailView: UIView()),
    Info(title: "Start", detailInfo: "챗봇 시작하기", color: .brown, detailView: UIView()),
]




