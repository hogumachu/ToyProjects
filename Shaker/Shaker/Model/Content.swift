struct Content: Decodable {
    var items: [Item]
}

struct Item: Decodable {
    var title: String?
    var link: String?
    var description: String?
    var telephon: String?
    var address: String?
    var roadAddress: String?
}

