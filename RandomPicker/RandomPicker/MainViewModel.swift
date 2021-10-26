class MainViewModel: ViewModelType {
    func fetch() -> [Content] {
        return storage.contentList()
    }
}
