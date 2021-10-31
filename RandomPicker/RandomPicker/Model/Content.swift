import RxDataSources

struct Content: IdentifiableType, Equatable {
    static func == (lhs: Content, rhs: Content) -> Bool {
        return lhs.title == rhs.title
    }
    
    let title: String
    var contents: [SubContent]
    
    var identity: String {
        return title
    }
}

struct SubContent: IdentifiableType, Equatable {
    static func == (lhs: SubContent, rhs: SubContent) -> Bool {
        return lhs.title == rhs.title
    }
    let title: String
    let score: Int
    
    var identity: String {
        return title
    }
}
