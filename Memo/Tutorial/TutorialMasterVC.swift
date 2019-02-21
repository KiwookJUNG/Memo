//
//  TutorialMasterVC.swift
//  Memo
//
//  Created by 정기욱 on 21/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class TutorialMasterVC: UIViewController {
    var pageVC: UIPageViewController! // 페이지 뷰 컨트롤러의 인스턴스를 참조할 멤버변수를 선언함.
    
    // 콘텐츠 뷰 컨트롤러의 콘텐츠에 사용될 데이터 배열 선언
    var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STPE 4"]
    var contentImages = ["Page0", "Page1", "Page2", "Page3"]
    
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        // 인덱스가 데이터 배열 크기 범위를 벗어나면 nil 반환
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        
        // "ContentsVC"라는 Storyboard ID를 가진 뷰 컨트롤러의 인스턴스를 생성하고 캐스팅한다.
        guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        
        // 콘텐츠 뷰 컨트롤러의 내용을 구성
        cvc.titleText = self.contentTitles[idx]
        cvc.imageFile = self.contentImages[idx]
        cvc.pageIndex = idx
        return cvc
    }
}
