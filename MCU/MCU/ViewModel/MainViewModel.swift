class MainViewModel {
    private var now: Mcu?
    private var loading = false
    
    var loadingStart: () -> Void = {}
    var loadingEnd: () -> Void = {}
    var dataUpdated: () -> Void = {}
    
    func fetchOrigin() {
        if loading { return }
        loading = true
        loadingStart()
        
        Repository.shared.fecthData("") { mcu in
            self.now = mcu
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
            self.now = mcu
            self.dataUpdated()
            self.loadingEnd()
            self.loading = false
        }
    }
    
    func getData() -> Mcu {
        guard let now = now else {
            return Mcu.empty
        }
        return now
    }
}
