//
//  ViewController.swift
//  myExpandableTableViewCell_tutorial
//
//  Created by Jeff Jeong on 2020/11/04.
//

import UIKit
import ExpyTableView

class ViewController: UIViewController, ExpyTableViewDelegate, ExpyTableViewDataSource, MyCellDelegate {
    
   
    

    @IBOutlet var myExpandableTableView: ExpyTableView!
    
    // 테이블 뷰의 데이터
    let contentArray = [
        ["섹션1 - 하나", "섹션1 - 둘"],
        ["섹션2 - 하나", "섹션2 - 둘", "섹션2 - 셋"],
        ["섹션3 - 하나", "섹션3 - 둘"],
        ["섹션4 - 하나"],
        ["섹션5 - 하나", "섹션5 - 둘"],
        ["섹션6 - 하나"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myExpandableTableView.dataSource = self
        myExpandableTableView.delegate = self
        
    }

    
    //MARK: - ExpyTableView 델리겟
    // 열리고 닫히고 상태가 변경될 때
    func tableView(_ tableView: ExpyTableView, expyState state: ExpyState, changeForSection section: Int) {
        print("changeForSection: \(section)")
        switch state {
        case .willExpand:
            print("펼쳐질 꺼다/ .willExpand")
        case .willCollapse:
            print("닫힐 꺼다 /.willCollapse")
        case .didExpand:
            print("펼쳐짐 / .didExpand")
        case .didCollapse:
            print("닫힘 /.didCollapse")
        }
    }
    
    //MARK: - ExpyTableView 데이타 소스
    func tableView(_ tableView: ExpyTableView, canExpandSection section: Int) -> Bool {
        
        return true // true 로 설정하면 열 수 있다
//        return false // 열 수 없다
    }
    
    // 펼치는 섹션 즉 헤더쎌 설정
    func tableView(_ tableView: ExpyTableView, expandableCellForSection section: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyHeaderCell") as! MyHeaderCell
        cell.titleLabel.text = "섹션 \(section + 1) 입니다"
        
        // 쏄을 클릭했을때 회색 색깔 흰색으로 변경
        let bgView = UIView()
        bgView.backgroundColor = .white
        cell.selectedBackgroundView = bgView
        
        cell.sectionIndex = section
        
        // 스위치 버튼 클릭 처리를 위한 델리겟 연결
        cell.delegate = self
        
        return cell
    }
    
    // 각 섹션에 들어갈 row의 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray[section].count + 1
    }
    
    // 펼쳐진 쎌을 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDetailCell") as! MyDetailCell
        cell.titleLabel.text = (contentArray[indexPath.section])[indexPath.row - 1]
        
        return cell
    }
    
    // 쎅션의 갯수 설정
    func numberOfSections(in tableView: UITableView) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    //MARK: - MyCellDelegate 메소드
    func didSwitchBtnClick(cell: MyHeaderCell) {
        print("ViewController - didSwitchBtnClick() called / cell.sectionIndex : \(cell.sectionIndex)")
        
        switch cell.mySwitch.isOn {
        case true:
            myExpandableTableView.expand(cell.sectionIndex)
        case false:
            myExpandableTableView.collapse(cell.sectionIndex)
        }
        
        
        
        
    }
}

class MyHeaderCell: UITableViewCell, ExpyTableViewHeaderCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mySwitch: UISwitch!
    @IBOutlet var arrowImgView: UIImageView!
    
    // 이벤트 전달을 위한 델리겟
    weak var delegate : MyCellDelegate?
    
    var sectionIndex: Int = 0 {
        didSet{
            print("MyHeaderCell - sectionIndex didSet() / : \(sectionIndex)")
        }
    }
    
    @IBAction func onMySwitchValueChanged(_ sender: UISwitch) {
        print("MyHeaderCell - onMySwitchValueChanged() called / sender.isOn : \(sender.isOn)")
        // 델리겟을 통해 스위치의 값이 변경되었다고 알리기
        delegate?.didSwitchBtnClick(cell: self)
    }
    
    // 해당 헤더 쎌의 상태를 알 수 있다
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        print("MyHeaderCell - state : \(state) / cellReuse: \(cellReuse)")
        switch state {
        case .willExpand:
            print("펼쳐질 예정")
            self.mySwitch.setOn(true, animated: !cellReuse)
            self.arrowDown(animated: !cellReuse)
            
            
        case .willCollapse:
            print("접힐 예정")
            self.mySwitch.setOn(false, animated: !cellReuse)
            self.arrowRight(animated: !cellReuse)
        case .didExpand:
            print("펼쳐짐")
        case .didCollapse:
            print("접혀짐")
        }
    }
    
    // 화살표 아래로 회전
    fileprivate func arrowDown(animated: Bool){
        // animated == true - 0.3
        // animated == false - 0
        // animated == true ? 0.3 : 0
        UIView.animate(withDuration: (animated ? 0.3 : 0), animations: {
            self.arrowImgView.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        })
    }
    
    // 화살표 원래 상태로 돌리기
    fileprivate func arrowRight(animated: Bool){
        // animated == true - 0.3
        // animated == false - 0
        // animated == true ? 0.3 : 0
        UIView.animate(withDuration: (animated ? 0.3 : 0), animations: {
            self.arrowImgView.transform = CGAffineTransform(rotationAngle: 0)
        })
    }
    
}


class MyDetailCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    
}

protocol MyCellDelegate: class {
    func didSwitchBtnClick(cell: MyHeaderCell)
}
