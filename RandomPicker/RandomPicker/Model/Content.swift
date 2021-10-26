import RxDataSources

struct Content: IdentifiableType, Equatable {
    static func == (lhs: Content, rhs: Content) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    let title: String
    var contents: [SubContent]
    let identity: String
    
    init(title: String, contents: [SubContent]) {
        self.title = title
        self.contents = contents
        self.identity = title
    }
}

struct SubContent: Equatable {
    static func == (lhs: SubContent, rhs: SubContent) -> Bool {
        return lhs.title == rhs.title
    }
    let title: String
    let score: Double
}
