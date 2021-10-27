import RxSwift
import RxDataSources

typealias ContentSectionModel = AnimatableSectionModel<Int, Content>

class MainViewModel: ViewModelType {
    let dataSource: RxTableViewSectionedAnimatedDataSource<ContentSectionModel> = {
        let ds = RxTableViewSectionedAnimatedDataSource<ContentSectionModel> { ds, tableView, indexPath, content in
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
            cell.titleLabel.text = content.title
            return cell
        }
        return ds
    }()
    
    var contentList: Observable<[ContentSectionModel]> {
        return storage.contentList()
    }
    
    func update(_ content: Content) {
        self.storage.createConent(content)
    }
    
    func update(_ content: Content, subContent: SubContent) {
        self.storage.createSubContent(content, subContent)
    }
    
    func delete(_ content: Content) {
        self.storage.deleteContent(content)
    }
    
    func delete(_ content: Content, _ subContent: SubContent) {
        self.storage.deleteSubContent(content, subContent)
    }
}
