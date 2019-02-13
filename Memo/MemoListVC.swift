//
//  MemoListVC.swift
//  Memo
//
//  Created by 정기욱 on 13/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class MemoListVC: UITableViewController {

    // 메모리스트는 사용자가 작성한 메모를 기반으로 저장된 정보를 읽어오는 것이므로
    // 앱델리게이트에 저장된 메모가 필요하다
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    // 테이블 행의 개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }

    // 테이블 행을 구성하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        
        // 2. 이미지 속성이 비어 있을 경우 "memoCell" 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        // 3. 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다.
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        // 4. memoCell의 내용을 구성한다.
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        // 5. Date 타입의 날짜를 yyyy-MM-dd HH:mm:ss 포맷에 맞게 변경한다
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        return cell
    }

    
    // 디바이스 스크린 뷰 컨트롤러가 나타날 때마다 호출되는 메소드
    // 즉 새로고침 역할
    override func viewWillAppear(_ animated: Bool) {
        // 테이블 데이터를 다시 읽어 들인다. 이에 따라 행을 구성하는 로직이 다시 실행됨.
        self.tableView.reloadData()
    }

}
