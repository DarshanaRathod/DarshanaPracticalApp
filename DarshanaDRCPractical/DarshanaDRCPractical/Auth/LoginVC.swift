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
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.setNeedsLayout()
        }
        
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
                        UserDefaults.standard.set(txtEmail.text, forKey: "user_email")
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
                        let nav = UINavigationController(rootViewController: homeViewController)
                        nav.isNavigationBarHidden = true
                        appDelegate.window?.rootViewController = nav
                        appDelegate.window?.makeKeyAndVisible()
                    }else{
                        showToast(message: "Email id or Password was incorrect")
                    }
                   
                }
          
        } catch {
            print("Fetching data Failed")
        }
    }
    
    
}


