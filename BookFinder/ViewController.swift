//
//  ViewController.swift
//  BookFinder
//
//  Created by test on 2018. 11. 12..
//  Copyright © 2018년 ksh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var webs: UIWebView!
    // webs 라는 WEBVIEW 변수 생성
    var urlC = ""
    // urlC 라는 url에 사용할 변수지정
    override func viewDidLoad() {
        super.viewDidLoad()
        if urlC != nil  {
            print("urlC:\(urlC)")
            // urlC가 nil이 아니면 urlC를 출력하고
        let url = URL(string: urlC)
            // url이라는 변수를 만들어주는데 String타입을 url타입으로 바꿔서 만들어준다
            if url != nil {
            print("url:\(url)")
                // url이 nil이 아니면 url을 출력해라
        webs.loadRequest(URLRequest(url: url!))
                // url을 불러들이는 코드
            }
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
