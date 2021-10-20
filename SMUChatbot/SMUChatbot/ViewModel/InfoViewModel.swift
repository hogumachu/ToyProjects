class InfoViewModel {
    var info: [Info] = myChatbotInfo
    
    
    func sceneSelect(_ cellNumber: Int) -> Scene {
        switch cellNumber {
        case 0:
            return .infoDetailTeamViewController
        case 1:
            return .infoDetailUseViewController
        default:
            return .chatViewController
        }
    }
}
