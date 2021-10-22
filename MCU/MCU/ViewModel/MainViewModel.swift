class MainViewModel {
    private var loading = false
    private var mcuList: [Mcu] = []
    
    var loadingStart: () -> Void = {}
    var loadingEnd: () -> Void = {}
    var dataUpdated: () -> Void = {}
    
    func fetchOrigin() {
        if loading { return }
        loading = true
        loadingStart()
        
        Repository.shared.fecthData("") { mcu in
            if let mcu = mcu {
                self.mcuList.append(mcu)
            }
            self.dataUpdated()
            self.loadingEnd()
            self.loading = false
            
            
        }
    }
    
    func fetchNext(_ date: String) {
        if loading { return }
        loading = true
        loadingStart()
        Repository.shared.fecthData(date) { mcu in
            if let mcu = mcu {
                self.mcuList.append(mcu)
            }
            self.dataUpdated()
            self.loadingEnd()
            self.loading = false
        }
    }
    
    func fetchPrevious() {
        guard !mcuList.isEmpty else { return }
        _ = mcuList.removeLast()
        
        if loading { return }
        loading = true
        loadingStart()
        dataUpdated()
        loadingEnd()
        loading = false
    }
    
    func getData() -> Mcu {
        guard let now = mcuList.last else {
            return Mcu.empty
        }
        return now
    }
    
    func getBefore() -> Mcu? {
        if mcuList.count >= 2 {
            return mcuList[mcuList.count - 2]
        }
        return nil
    }
}
