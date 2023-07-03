//
//  cartViewController.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 03/07/23.
//

import UIKit
import CoreData

class cartViewController: UIViewController {

    @IBOutlet weak var lblprice: UILabel!
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData();
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func fetchData(){
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if(result.isEmpty){
                showToast(message: "No Data Found")
                return
            }
            print(result);
                for data in result as! [NSManagedObject] {
                    let email = data.value(forKey: "user_email") as! String
                    let price = data.value(forKey: "price") as! String
                    var loginUserEmail = UserDefaults.standard.value(forKey: "user_email")
                    if(loginUserEmail as! String==email){
                        lblprice.text = String(price)
                    }
                }
          
        } catch {
            print("Fetching data Failed")
        }
    }

}
