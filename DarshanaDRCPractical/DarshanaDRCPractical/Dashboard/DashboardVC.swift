//
//  DashboardVC.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit
import Moya
import ObjectMapper
import SwiftyJSON
import CoreData

class DashboardVC: UIViewController {

    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var tblProductList: UITableView!

    var arrProductList = [Products]()
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getProductList()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    @IBAction func btnLogoutAction(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "login_data")
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let logineViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let nav = UINavigationController(rootViewController: logineViewController)
        nav.isNavigationBarHidden = true
        appDelegate.window?.rootViewController = nav
        appDelegate.window?.makeKeyAndVisible()
    }
    
    @IBAction func btnAddCardAction(_ sender: UIButton) {
        ///Add To Cart in Core Data

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let cartViewController = storyBoard.instantiateViewController(withIdentifier: "cartViewController") as! cartViewController
        self.navigationController?.pushViewController(cartViewController, animated: true)
    }
    

    
    func getProductList(){
        let provider = MoyaProvider<MyService>()
        
        provider.request(.productList) { result in
            switch result {
               case let .success(moyaResponse):
                let statusCode = moyaResponse.statusCode
                if(statusCode == 200){
                    
                let productList = try? JSONDecoder().decode([Products].self, from: moyaResponse.data)
                    self.arrProductList = productList!
                    self.tblProductList.reloadData()

                }
               
                    case let .failure(error):
                   // TODO: handle the error == best. comment. ever.
                debugPrint("Error"+"\(error)")
               }
        }
    }
    
    func openDatabse(price: String, item_count:String,id: String, category:String){
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newUser, price: price,item_count: item_count,id: id,category: category)
    }
    
    func saveData(UserDBObj:NSManagedObject, price: String, item_count:String,id: String, category:String){
        var loginUserEmail = UserDefaults.standard.value(forKey: "user_email")
        UserDBObj.setValue(loginUserEmail, forKey: "user_email")
        UserDBObj.setValue(String(price), forKey: "price")
        UserDBObj.setValue(String(item_count), forKey: "item_count")
        UserDBObj.setValue(String(id), forKey: "id")
        UserDBObj.setValue(String(category), forKey: "category")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
    }
    
}

extension DashboardVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "tblProductCell"
              var cell: tblProductCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? tblProductCell
              if cell != nil {
                 
                  cell = tblProductList.dequeueReusableCell(withIdentifier: identifier) as? tblProductCell
                  let product = arrProductList[indexPath.row]
                  cell.lblProductName.text = product.title
                  cell.lblPrice.text = String(product.price)
                  cell.imgProduct.sd_setImage(with: URL(string: "\(product.image)"))
                  cell.stepper.tag = indexPath.row
                  cell.stepper.value = 0
                  cell.lblQuantity.text = "0"
                 
              }
              return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = arrProductList[indexPath.row]
        openDatabse(price: String(product.price), item_count: "1", id: String(product.id), category: String(product.category))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}
