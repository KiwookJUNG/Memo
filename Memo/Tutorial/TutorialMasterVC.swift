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
    
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        // 1. 페이지 뷰 컨트롤러 객체 생성하기
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as! UIPageViewController
        self.pageVC.dataSource = self // 생성된 인스턴스의 dataSource 속성은 self로 설정하여, 데이터 소스 구성에
        // 필요한 메소드가 현재의 클래스 인스턴스 자신에게 구현되어 있다는 것을 알려준다.
        
        // 2. 페이지 뷰 컨트롤러의 기본 페이지 지정
        let startContentVC = self.getContentVC(atIndex: 0)! // 최초 노출될 콘텐츠 뷰 컨트롤러
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true)
        // 페이지 뷰 컨트롤러가 실행되면 사용자의 스와이프 액션이 있기 전까지 임의의 콘텐츠 뷰를 기본 값으로 출력하고 있어야함
        // 이 기본 값은 위의 두번째 줄의 메소드로 실행할 수 있음.
        
        
        // 3. 페이지 뷰 컨트롤러의 출력 영역 지정
        // 페이지 뷰 컨트롤러는 현재의 Master 클래스 화면 위에 표시되므로, 우리는 페이지 뷰 컨트롤러가 출력된 영역을 지정해줘야함
        // 페이지 뷰 컨트롤러와 그의 콘텐츠 뷰들이 화면 상단부터 빼곡히 채우도록 기준 좌표 0,0으로하고 높이를 적절히 지정해줌
        self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        // 4. 페이지 뷰 컨트롤러를 마스터 뷰 컨트롤러의 자식 뷰 컨트롤러로 설정
        self.addChild(self.pageVC) // 페이지 뷰 컨트롤러를 마스터의 자식으로 등록
        self.view.addSubview(self.pageVC.view) // 그 컨트롤러의 뷰 또한 서브뷰로 등록
        self.pageVC.didMove(toParent: self) // 자식 뷰 컨트롤러에게 부모 뷰 컨트롤러가 바뀌었음을 알려줌.
    }
    
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
    
    
    // 페이지 인디케이터를 화면에 출력하기 위해서, 페이지 뷰 컨트롤러가 출력할 페이지가 모두 몇개 인지
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count // 출력할 페이지의 개수
    }
    // 맨 처음에 선택되어 있을 페이지 정보를 알려줘야함
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0 // 최초에 출력할 콘텐츠 뷰의 인덱스 번호
    }
}
