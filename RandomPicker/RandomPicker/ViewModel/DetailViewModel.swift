import RxSwift
import RxCocoa
import RxDataSources

typealias SubContentSectionModel = AnimatableSectionModel<Int, SubContent>

class DetailViewModel: ViewModelType {
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
}
