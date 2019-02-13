//
//  MemoFormVC.swift
//  Memo
//
//  Created by 정기욱 on 13/02/2019.
//  Copyright © 2019 Kiwook. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController{

    var subject : String!
    
    @IBOutlet var memo: UITextView!
    
    @IBOutlet var preview: UIImageView!
    
    @IBAction func save(_ sender: Any) {
        
        // 내용을 입력하지 않는 경우
        guard self.memo.text?.isEmpty == false else {
            let alert = UIAlertController(title: "경고", message: "내용을 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        // MemoData 객체를 생성하고, 데이터를 담아줌.
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.memo.text
        data.image = self.preview.image
        data.regdate = Date()
        
        // 앱 델리게이트 객체를 읽어온 다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 클래스 타입이 무엇이든지 주어진 조건(UIApplicationDelegate 프로토콜 구현, @UIApplicationMain)
        // 을 만족하면 앱 델리게이트가 될 수 있기 때문에, 프로토콜 타입으로 객체를 반환해줌.
        // 즉, UIApplication.shared.delegate는 이들 클래스의 공통 분모인 UIApplicationDelegate 프로토콜 타입으로
        // 객체를 반환하므로 AppDelegate 로 타입 캐스팅을 해줘야한다.
        appDelegate.memolist.append(data)
        // memolist는 AppDelegate에 선언 해준 '구조체'이기 떄문에 직접 참조하지 않고 복사값을 전달하면
        // 복사값에만 값이 저장되므로 직접 적으로 참조해서 값을 추가해줘야함.
        
        // 작성폼 화면을 종료하고, 이전 화면으로 되돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        // 이미지 피커 화면을 띄워줌
        self.present(picker, animated: true)
    }
    
    override func viewDidLoad() {
        self.memo.delegate = self
    }
    
}

// MARK: - 이미지 피커 컨트롤러 델리게이트
extension MemoFormVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지 선택을 완료했을 때 호출되는 메소드
    
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // 선택된 이미지를 미리보기에 표시한다.
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        // 이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
        
    }
}

// MARK: - 텍스트 뷰 델리게이트

extension MemoFormVC: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        // 내용의 최대 15자리 까지 읽어 subject 변수에 저장한다.
        let memo = textView.text as NSString // NSString 과 String은 완전히 호환되므로 옵셔널 X
        let length = ( (memo.length > 15 ) ? 15 : memo.length)
        self.subject = memo.substring(with: NSRange(location: 0, length: length))
        
        
        // 네비게이션 타이틀에 표시한다.
        
        self.navigationItem.title = subject
    }
    
}



