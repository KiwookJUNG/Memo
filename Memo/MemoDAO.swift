//
//  MemoDAO.swift
//  Memo
//
//  Created by 정기욱 on 02/03/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit
import CoreData

class MemoDAO {
    // 1. 관리 객체 컨텍스트를 반환하는 멤버 변수 context를 추가
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // 2. 저장된 메모 전체를 불러오는 fetch() 메소드 구현
    func fetch() -> [MemoData] {
        var memolist = [MemoData]()
        // 2-1. 요청 객체 생성
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        // 2-1-1. 최신 글 순으로 정렬하도록 정렬 객체 생성
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        do {
            let resultset = try self.context.fetch(fetchRequest)
            
            // 2-2. 읽어온 결과 집합을 순회하면서 [MemoData] 타입으로 변환한다.
            for record in resultset {
                // 2-3. MemoData 객체를 생성한다.
                let data = MemoData()
                
                // 2-4. MemoMO 프로퍼티 값을 MemoData의 프로퍼티로 복사한다.
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate! as Date
                data.objectID = record.objectID
                
                // 2-4-1
                if let image = record.image as Data? {
                    data.image = UIImage(data: image)
                }
                
                // 2-5 MemoData 객체를 memolist 배열에 추가한다.
                memolist.append(data)
            }
            } catch let e as NSError {
                NSLog("An error has occurred : %s", e.localizedDescription)
            }
            return memolist
        
    }

}
