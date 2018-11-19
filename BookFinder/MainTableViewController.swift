//
//  MainTableViewController.swift
//  BookFinder
//
//  Created by D7702_10 on 2018. 11. 12..
//  Copyright © 2018년 ksh. All rights reserved.
//  비동기 프로그램

import UIKit

class MainTableViewController: UITableViewController {
    var items:[Any]?
    var myIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        search(query: "가을", page: 1)
    }
    
    func search(query:String, page:Int) {
        let str = "https://dapi.kakao.com/v3/search/book?query=\(query)&page=\(page)" as NSString  // NSString 쓰는 이유(문자나 한글도 쓰기위해)
        let key = "KakaoAK 3de8cb2ab93dab42a5e0dac56de67841"
        if let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: strURL) { // URL로 변형
                var request = URLRequest(url: url)
                request.addValue(key, forHTTPHeaderField: "Authorization")
                let session = URLSession.shared
                let task = session.dataTask(with: request, completionHandler: handler)
                task.resume()
            }
        }
    }
    
    // 콜백 함수
    func handler(data:Data?, response:URLResponse?, error:Error?) -> Void { // 에러가 있으면 nil이 아니다.
        if error != nil { return }
        
        if let dat = data {
            do {
                //throws 예외처리(항상 try catch문 써야함
                if let dic = try JSONSerialization.jsonObject(with: dat, options: []) as? [String:Any] {
                    if let books = dic["documents"] as? [Any] {
                        //print(books)
                        items = books
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print("parsing error")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let items = items {
            return items.count
        } else {
         return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RE", for: indexPath)
        if let books = items {
            if let book = books[indexPath.row] as? [String:Any] {
                cell.textLabel?.text = book["title"] as? String
                //cell.detailTextLabel?.text = book["authors"] as? String
            }
        }
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        //performSegue(withIdentifier: "segue", sender: self)
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as? ViewController
        if let books = items {
            if let book = books[indexPath.row] as? [String:Any] {
                if let urlB = book["url"] as? String {
                    //print(urlB)
                     vc?.urlC = urlB
                }
            }
        }
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
