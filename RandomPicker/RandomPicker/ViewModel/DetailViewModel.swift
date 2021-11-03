import RxSwift
import RxCocoa
import RxDataSources

typealias SubContentSectionModel = AnimatableSectionModel<Int, SubContent>

final class DetailViewModel: ViewModelType {
    struct Dependency {
        let content: Content
    }
    init(storage: Storable, dependency: Dependency) {
        self.content = dependency.content
        self.title = dependency.content.title
        super.init(storage: storage)
    }
    private var content: Content
    let title: String
    
    let dataSource: RxTableViewSectionedAnimatedDataSource<SubContentSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<SubContentSectionModel> { ds, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as? DetailTableViewCell ?? DetailTableViewCell(style: .default, reuseIdentifier: DetailTableViewCell.identifier)
            cell.titleLabel.text = item.title
            cell.scoreLabel.text = "점수 : \(item.score)"
            return cell
        }
        return ds
    }()
    
    let randomTableViewDataSource: RxTableViewSectionedAnimatedDataSource<SubContentSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<SubContentSectionModel> { ds, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: RandomTableViewCell.identifier, for: indexPath) as? RandomTableViewCell ?? RandomTableViewCell(style: .default, reuseIdentifier: RandomTableViewCell.identifier)
            cell.titleLabel.text = item.title
            return cell
        }
        return ds
    }()
    
    private lazy var subStore = BehaviorRelay<[SubContentSectionModel]>(value: [sectionModel])
    private lazy var sectionModel = SubContentSectionModel(model: 0, items: content.contents)
    
    var subContentList: Observable<[SubContentSectionModel]> {
        return subStore.asObservable()
    }
    
    func update(subContent: SubContent) {
        self.storage.createSubContent(content, subContent)
        updateContent()
    }
    
    private func updateContent() {
        content = storage.fetchData(content)
        sectionModel = SubContentSectionModel(model: 0, items: content.contents)
        subStore.accept([sectionModel])
    }
    
    func random() -> String {
        var randoms: [String] = []
        
        content.contents.forEach {
            for _ in 0..<$0.score {
                randoms.append($0.title)
            }
        }
        print(randoms)
        return randoms.randomElement() ?? ""
    }
    
    func validTitle(_ title: String) -> Bool {
        return !title.isEmpty && !content.contents.contains(where: {$0.title == title})
    }
    
    func checkAndUpdateContent(_ content: (title: String?, score: String?)) -> Bool {
        guard let title = content.title, let score = Int(content.score ?? "1"), validTitle(title), score > 0 && score <= 10 else {
            return false
        }
        update(subContent: SubContent(title: title, score: score))
        return true
        
    }
}
