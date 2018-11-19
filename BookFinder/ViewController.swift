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
    
    var urlC = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if urlC != nil  {
            print("urlC:\(urlC)")
        let url = URL(string: urlC)
            if url != nil {
            print("url:\(url)")
        webs.loadRequest(URLRequest(url: url!))
                
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
