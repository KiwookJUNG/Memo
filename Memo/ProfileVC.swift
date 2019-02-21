//
//  ProfileVC.swift
//  Memo
//
//  Created by 정기욱 on 19/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let uinfo = UserInfoManager() // 개인 정보 관리 매니저
    
    // 테이블 뷰가 사용되긴 했지만, 테이블 뷰 컨트롤러는 아니다
    // 따라서 테이블 뷰를 위한 프로토콜을 직접 추가해 주어야 우리가 원하는 테이블 뷰를 구현할 수 있다.
    // UITableViewDelegate는 테이블 뷰에서 발생하는 사용자 액션에 응답하기 위한 프로토콜
    // UITableViewDataSource는 데이터 소스를 이용하여 테이블 뷰를 구성하기 위해 필요한 프로토콜
    
    let profileImage = UIImageView() // 프로필 사진 이미지
    let tv = UITableView() // 프로필 목록
    
    override func viewDidLoad() {
        self.navigationItem.title = "프로필"
        
        // 1. 프로필 사진에 들어갈 기본 이미지
        let image = UIImage(named: "account.jpg")
        
        // 2. 프로필 이미지 처리
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 270)
        
        // 3. 프로필 이미지 둥글게 만들기
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        // 4. 루트뷰에 추가
        self.view.addSubview(self.profileImage)
        
        // 테이블뷰
        self.tv.frame = CGRect(x: 0, // 좌측 여백에 밀착하도록 0으로 설정
                               y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20,// 프로필 이미지 아래에 테이블 뷰가 위치해야함, 이를 위해 프로필 이미지의 y 좌표 위치 + 프로필 이미지 높이 + 20의 여백을 추가하여 대입
                               width: self.view.frame.width, // 너비는 화면전체를 채우도록
                               height: 100)
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
        
        
        // 뒤로 가기 버튼 처리
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
        
        let bg = UIImage(named: "profile-bg") // 이미지를
        let bgImg = UIImageView(image: bg) // 이미지뷰에 넣어줌
        
        bgImg.frame.size = CGSize(width: bgImg.frame.size.width, height: bgImg.frame.size.height)
        bgImg.center = CGPoint(x: self.view.frame.width / 2, y: 40)
        
        bgImg.layer.cornerRadius = bgImg.frame.size.width / 2
        bgImg.layer.borderWidth = 0
        bgImg.layer.masksToBounds = true
        self.view.addSubview(bgImg)
        
        self.view.bringSubviewToFront(self.tv)
        self.view.bringSubviewToFront(self.profileImage)
        
        // 내비게이션 바 숨김처리
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        // 셀 구현 내용
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0 :
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = "정기욱"
        case 1 :
            cell.textLabel?.text = "게정"
            cell.detailTextLabel?.text = "rldnr56@me.com"
        default :
            ()
        }
        
        return cell
    }
    
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func doLogin(_ sender: Any) {
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)
        
        // 알림창에 들어갈 입력폼 추가
        loginAlert.addTextField { (tf) in
            tf.placeholder = "Your Account"
        }
        loginAlert.addTextField { (tf) in
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true
        }
        
        // 알림창 버튼 추가
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive, handler: { (_) in
            let account = loginAlert.textFields?[0].text ?? "" // 첫 번째 필드 : 계정
            let passwd = loginAlert.textFields?[1].text ?? "" // 두 번째 필드 : 비밀 번호
            
            if self.uinfo.login(account: account, passwd: passwd){
                // 로그인 성공 시 처리할 내용이 여기에 들어갈 예정입니다.
                
            } else {
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: false)
            }
        }))
        
        self.present(loginAlert, animated: false)
    }
    
    @objc func doLogout(_ sender: Any) {
        let msg = "로그아웃을 하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive, handler: { (_) in
            if self.uinfo.logout() {
                // 로그 아웃시 처리할 내용이 여기 들어간다.
            }
            }))
        
        self.present(alert, animated: false)
    }
}
