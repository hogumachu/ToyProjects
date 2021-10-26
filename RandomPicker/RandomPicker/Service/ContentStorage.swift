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
    
    func contentList() -> [Content] {
        return contents
    }
}
