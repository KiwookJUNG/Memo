//
//  SideBarVC.swift
//  Memo
//
//  Created by 정기욱 on 19/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class SideBarVC: UITableViewController{

    let uinfo = UserInfoManager()
    // 유저정보를 갱신해주기 위해 객체 인스턴스 할당
    
    
    let nameLabel = UILabel() // 이름 레이블
    let emailLabel = UILabel() // 이메일 레이블
    let profileImage = UIImageView() // 프로필 이미지
    
    
    // 목록 데이터 배열
    let titles = ["새글 작성하기", "친구 새글", "달력으로 보기", "공지사항", "통계", "계정 관리"]
    
    // 아이콘 데이터 배열
    let icons = [
       UIImage(named: "icon01.png"),
       UIImage(named: "icon02.png"),
       UIImage(named: "icon03.png"),
       UIImage(named: "icon04.png"),
       UIImage(named: "icon05.png"),
       UIImage(named: "icon06.png")
    ]
    
    override func viewDidLoad() {
        // 테이블 뷰의 헤더 역할을 할 뷰를 정의한다.
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.brown
        
        // 테이블 뷰의 헤더 뷰로 지정한다.
        self.tableView.tableHeaderView = headerView
        
        // 이름 레이블의 속성을 정의하고, 헤더 뷰에 추가한다.
        self.nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        //self.nameLabel.text = "오늘 눈온다"
        self.nameLabel.textColor = UIColor.white // 텍스트 색상
        self.nameLabel.font = UIFont.boldSystemFont(ofSize: 15) // 폰트 사이즈
        self.nameLabel.backgroundColor = UIColor.clear // 배경 색상
        
        headerView.addSubview(self.nameLabel) // 헤더 뷰에 추가
        
        // 이메일 레이블의 속성을 정의하고, 헤더 뷰에 추가한다.
        self.emailLabel.frame = CGRect(x: 70, y: 30, width: 100, height: 30) // 위치와 크기를 정의
        
        //self.emailLabel.text = "rldnr56@me.com" // 기본 텍스트
        self.emailLabel.textColor = UIColor.white
        self.emailLabel.font = UIFont.systemFont(ofSize: 11)
        self.emailLabel.backgroundColor = UIColor.clear // 배경 색상
        
        headerView.addSubview(self.emailLabel) // 헤더 뷰에 추가
        
        //let defaultProfile = UIImage(named: "account.jpg")
        //self.profileImage.image = defaultProfile // 이미지 등록
        self.profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50) // 위치와 크기를 정의
        
        self.profileImage.layer.cornerRadius = (self.profileImage.frame.width / 2) // 반원 형태로 라운딩
        self.profileImage.layer.borderWidth = 0 // 테두리 두께 0으로
        self.profileImage.layer.masksToBounds = true // 마스크 효과
        
        view.addSubview(self.profileImage) // 헤더 뷰에 추가
        
    }
    
    // 사이드 바가 화면에 표시될 때마다 로그인 정보를 읽어와 갱신하도록 해준다.
    // viewWillAppear은 화면이 표시 될 때마다 호출되는 메소드이다.
    // SWReavealViewController 라이브러리에 의해 관리되는 사이드 바는
    // 닫히고 난 다음에도 사라지지 않고 그대로 메모리에 유지되기 떄문에, viewDidLoad 메소드에
    // 위 내용을 작성해 놓으면 로그인/로그아웃 후에도 화면이 갱신되지 않는 문제가 생긴다.
    // 따라서 viewWillAppear에 작성해야한다.
    override func viewWillAppear(_ animated: Bool) {
        self.nameLabel.text = self.uinfo.name ?? "Guest"
        self.emailLabel.text = self.uinfo.account ?? ""
        self.profileImage.image = self.uinfo.profile
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "menucell" // 테이블 셀 식별자
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지를 대입한다.
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // 0버째 셀은 새글 작성 메뉴임, 즉 사용자가 새글작성 탭을 눌렀을 때
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "MemoForm")
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            target.pushViewController(uv!, animated: true)
            self.revealViewController()?.revealToggle(self)
        } else if indexPath.row == 5 {
            // 계정 관리
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "_Profile")
            self.present(uv!, animated: true) {
                self.revealViewController()?.revealToggle(self)
            }
        }
    }
    
}
