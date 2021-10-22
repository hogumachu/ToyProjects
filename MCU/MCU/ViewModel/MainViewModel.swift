class MainViewModel {
    private var loading = false
    private var mcuList: [Mcu] = []
    
    var loadingStart: () -> Void = {}
    var loadingEnd: () -> Void = {}
    var dataUpdated: () -> Void = {}
    
//    func fetchOrigin() {
//        if loading { return }
//        loading = true
//        loadingStart()
//        
//        Repository.shared.fecthData("") { result in
//            switch result {
//            case .success(let mcu):
//                self.mcuList.append(mcu)
//                self.dataUpdated()
//                self.loadingEnd()
//                self.loading = false
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    func fecthData(_ date: String = "") {
        if loading { return }
        loading = true
        loadingStart()
        Repository.shared.fecthData(date) { result in
            switch result {
            case .success(let mcu):
                self.mcuList.append(mcu)
                self.dataUpdated()
                self.loadingEnd()
                self.loading = false
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPrevious() {
        if loading || mcuList.isEmpty { return }
        _ = mcuList.removeLast()
        loading = true
        loadingStart()
        dataUpdated()
        loadingEnd()
        loading = false
    }
    
    func getData() -> Mcu {
        return mcuList.last ?? Mcu.empty
    }
    
    func getBefore() -> Mcu? {
        return mcuList.count >= 2 ? mcuList[mcuList.count - 2] : nil
    }
}
