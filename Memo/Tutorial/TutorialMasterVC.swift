//
//  TutorialMasterVC.swift
//  Memo
//
//  Created by 정기욱 on 21/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {
    // UIPageViewControllerDataSource 는 페이지 뷰 컨트롤러의 데이터 소스 구현과 관련된 프로토콜
    // 여기서 말하는 데이터 소스는, 사용자가 페이지 뷰 컨트롤러의 화면을 앞뒤로 스와이프 할때마다 표시될 콘텐츠 뷰 컨트롤러를 의미함.
    
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
    
    // 현재의 콘텐츠 뷰 컨트롤러보다 앞쪽에 올 콘텐츠 뷰 컨트롤러 객체
    // 즉, 현재의 상태에서 앞쪽으로 스와이프했을 때 보여줄 콘텐츠 뷰 컨트롤러 객체
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 현재의 페이지 인덱스 (인자값으로 전달된 뷰 컨트롤러에서 현재의 페이지 인덱스를 추출)
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        // 현재의 인덱스가 맨 앞이라면 nil을 반환하고 종료
        guard index > 0 else {
            return nil
        }
        
        index -= 1 // 현재의 인덱스에서 하나 뺌(즉, 이전 페이지 인덱스)
        return self.getContentVC(atIndex: index)
        
    }
    
    
    // 현재의 콘텐츠 뷰 컨트롤러보다 뒤쪽에 올 콘텐츠 뷰 컨트롤러 객체
    // 즉, 현재의 상태에서 뒤쪽으로 스와이프했을 때 보여줄 콘텐츠 뷰 컨트롤러 객체
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 현재의 페이지 인덱스
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        index += 1
        
        // 인덱스는 항상 배열의 데이터 크기보다 작아야한다.
        guard index < self.contentTitles.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
}
