//
//  DashboardVC.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit

class DashboardVC: UIViewController {

    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var tblProductList: UITableView!
    
//    var arrProductList = ProductList
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    @IBAction func btnLogoutAction(_ sender: UIButton) {
    }
    
    @IBAction func btnAddCardAction(_ sender: UIButton) {
    }
}

//extension DashboardVC: UITableViewDataSource, UITableViewDelegate{
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrProductList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let identifier = "tblProductCell"
//              var cell: tblProductCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? tblProductCell
//              if cell == nil {
//                  tblProductList.register(UINib(nibName: "tblProductCell", bundle: nil), forCellReuseIdentifier: identifier)
//                  cell = tblProductList.dequeueReusableCell(withIdentifier: identifier) as? NotificationTblCell
//              }
//              return cell
//    }
//}
