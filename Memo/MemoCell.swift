//
//  MemoCell.swift
//  Memo
//
//  Created by 정기욱 on 13/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class MemoCell: UITableViewCell {

 
    @IBOutlet var subject: UILabel! // 메모 제목
    
    @IBOutlet var contents: UILabel! // 메모 내용
    
    @IBOutlet var regdate: UILabel! // 등록 일자
    
    @IBOutlet var img: UIImageView! // 이미지
    
    
}
