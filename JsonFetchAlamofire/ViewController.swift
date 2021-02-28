//
//  ViewController.swift
//  JsonFetchAlamofire
//
//  Created by Muhammad Ilham Ashiddiq Tresnawan on 28/02/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        fetchData() 
    }

    func fetchData(){
        let urlAdress = "https://swapi.dev/api/films"
        
        AF.request(urlAdress, method: .get)
            .responseJSON(completionHandler: { response in
//            print(response)
                let dataJSON = try? JSON(data: response.data!)
//                print(dataJSON!["results"])
                let myData = dataJSON!["results"]
                
                self.titleList.removeAll()
                
                for i in myData.arrayValue {
//                    print(i)
                    let title = i["title"].stringValue
                    self.titleList.append(title)
                    print(title)
                }
                self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(titleList)
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = titleList[indexPath.row]
        return cell!
    }
}

