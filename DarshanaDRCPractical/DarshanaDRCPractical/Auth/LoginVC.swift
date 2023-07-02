//
//  LoginVC.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit
import CoreData

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var context:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Validation
    func validate() -> Bool {
        if txtEmail.text!.isEmpty{
            showToast(message: "Please enter email")
            return false
        }else if !(isValidEmail(txtEmail.text!)){
            showToast(message: "Please enter valid email")
             return false
         }else if txtPassword.text!.isEmpty{
             showToast(message: "Please enter password")
             return false
        }else{
            return true
        }
    }
    
    // MARK: - Button Action
    @IBAction func btnSignupAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        if validate(){
            fetchData()
        }
    }
}


//MARK: Functions
extension LoginVC{
    func openDatabse(email: String, password:String){
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        saveData(UserDBObj:newUser, email: txtEmail.text!, password:txtPassword.text!)
    }
    
    func saveData(UserDBObj:NSManagedObject, email: String, password:String){
        UserDBObj.setValue(email, forKey: "email")
        UserDBObj.setValue(password, forKey: "password")
        do {
            try context.save()
        } catch {
            print("Storing data Failed")
        }
        fetchData()
    }
    
    func fetchData(){
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if(result.isEmpty){
                showToast(message: "No Data Found")
                return
            }
            for data in result as! [NSManagedObject] {
                let email = data.value(forKey: "email") as! String
                let password = data.value(forKey: "password") as! String
              
                if(txtEmail.text == email && txtPassword.text == password){
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "DashboardVC")  as! DashboardVC
                    let navigationController = UINavigationController.init(rootViewController: initialViewController)
                    navigationController.setNavigationBarHidden(true, animated: false)
                    appDelegate.window?.rootViewController = navigationController
                    appDelegate.window?.makeKeyAndVisible()
                }
                break
            }
        } catch {
            print("Fetching data Failed")
        }
    }
    
    
}


