import RxSwift

class ContentStorage: Storable {
    
    
    private var contents: [Content] = [
        Content.init(title: "음식", contents: [
            .init(title: "삼겹살", score: 4),
            .init(title: "짜장면", score: 3),
            .init(title: "마라탕", score: 3),
            .init(title: "부대찌개", score: 4),
            .init(title: "피자", score: 5)
        ])
    ]
    private lazy var store = BehaviorSubject<[ContentSectionModel]>(value: [sectionModel])
    private lazy var sectionModel = ContentSectionModel(model: 0, items: contents)
    
    @discardableResult
    func contentList() -> Observable<[ContentSectionModel]> {
        return store
    }
    
    func createConent(_ content: Content) {
        sectionModel.items.insert(content, at: 0)
        store.onNext([sectionModel])
    }
    
    func createSubContent(_ content: Content, _ subContent: SubContent) {
        sectionModel.items.firstIndex(of: content)
            .map { sectionModel.items[$0].contents.append(subContent) }
        store.onNext([sectionModel])
    }
    
    func deleteContent(_ content: Content) {
        sectionModel.items.firstIndex(of: content)
            .map { _ = sectionModel.items.remove(at: $0) }
        store.onNext([sectionModel])
    }
    
    func deleteSubContent(_ content: Content, _ subContent: SubContent) {
        sectionModel.items.firstIndex(of: content)
            .map {
                if let index = sectionModel.items[$0].contents.firstIndex(where: { $0 == subContent}) {
                    sectionModel.items[$0].contents.remove(at: index)
                }
            }
        store.onNext([sectionModel])
    }
}
