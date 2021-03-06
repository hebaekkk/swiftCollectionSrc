import Foundation
import AsyncDisplayKit
import RxSwift
import RxCocoa

class ExViewController: ASDKViewController<ASTableNode> {
    private var firstItems: [ExData] = [
        ExData(title: "1111", desc: "1212"),
        ExData(title: "2222", desc: "22333"),
        ExData(title: "3333", desc: "3323"),
    ]
    private var secondItems = [
        DCellData()
    ]
    private var context: ASBatchContext?
    
    private let disposeBag = DisposeBag()
    
    override init() {
        let tableNode = ASTableNode(style: .plain)
        tableNode.backgroundColor = .white
        tableNode.automaticallyManagesSubnodes = true
        super.init(node: tableNode)
        
        self.title = "Reposivarvary"
        
        // main thread
        self.node.onDidLoad({ node in
            guard let `node` = node as? ASTableNode else { return }
            node.view.separatorStyle = .singleLine
        })
        
        self.node.leadingScreensForBatching = 2.0
        self.node.dataSource = self
        self.node.delegate = self
        self.node.allowsSelectionDuringEditing = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.firstItems.count
        }
        
        return self.secondItems.count
    }
    
    /*
     Node Block Thread Safety Warning
     It is very important that node blocks be thread-safe.
     One aspect of that is ensuring that the data model is accessed outside of the node block.
     Therefore, it is unlikely that you should need to use the index inside of the block.
     */
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            if indexPath.section == 0 {
                let data = self.firstItems[indexPath.row]
                return ExCellNode(data: data)
            }
            
            let data = self.secondItems[indexPath.row]
            return DCellNode(data: data)
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if indexPath.section == 0 {
            let data = self.firstItems[indexPath.row]
            return ExCellNode(data: data)
        }
        
        let data = self.secondItems[indexPath.row]
        return DCellNode(data: data)
    }
}

extension ExViewController: ASTableDelegate {
    // block ASBatchContext active state
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return self.context == nil
    }
    
    // load more
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        self.context = context
    }
    
    // editable cell
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.node.performBatchUpdates({
                if indexPath.section == 0 {
                    self.firstItems.remove(at: indexPath.row)
                }
                else {
                    self.secondItems.remove(at: indexPath.row)
                }

                self.node.deleteRows(at: [indexPath], with: .fade)
            }, completion: nil)
        }
    }
}

extension ExViewController {
    func openUserProfile(id: Int) {
        //        guard let index = self.items.index(where: { $0.id == id }) else { return }
        //        let viewModel = self.items[index]
        //        let viewController = UserProfileViewController(viewModel: viewModel)
        //        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

