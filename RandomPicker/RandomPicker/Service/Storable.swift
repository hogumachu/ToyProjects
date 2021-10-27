import RxSwift

protocol Storable {
    @discardableResult
    func contentList() -> Observable<[ContentSectionModel]>
    
    func createConent(_ content: Content) -> Void
    
    func createSubContent(_ content: Content, _ subContent: SubContent) -> Void
    
    func deleteContent(_ content: Content) -> Void
    
    func deleteSubContent(_ content: Content, _ subContent: SubContent) -> Void
    
    func fetchData(_ content: Content) -> Content
}
