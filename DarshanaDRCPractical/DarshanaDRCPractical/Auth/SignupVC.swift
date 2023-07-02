//
//  SignupVC.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Validation
    func validate() -> Bool {
        if txtUsername.text!.isEmpty{
            showToast(message: "Please enter email")
            return false
        }else if txtUsername.text!.count < 3{
            showToast(message: "Username must be at least 3 char")
            return false
        }else if txtEmail.text!.isEmpty{
            showToast(message: "Please enter email")
            return false
        }else if !(isValidEmail(txtEmail.text!)){
            showToast(message: "Please enter valid email")
             return false
         }else if txtPhoneNo.text!.isEmpty{
            showToast(message: "Please enter phone number")
            return false
        }else if txtPhoneNo.text!.count < 10 || txtPhoneNo.text!.count > 15{
            showToast(message: "Please enter valid phone no")
            return false
        }else if txtPassword.text!.isEmpty{
             showToast(message: "Please enter password")
             return false
        }else if txtPassword.text!.count < 6{
             showToast(message: "Password must be at least 6 char")
             return false
        }else if txtConfirmPassword.text!.count < 6{
            showToast(message: "Please enter confirm password")
             return false
        }else if txtPassword.text! != txtConfirmPassword.text!{
            showToast(message: "Password and confirm password do not match")
             return false
        }else{
            return true
        }
    }
    

    // MARK: - Button Action
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        self.present(nextViewController, animated:true, completion:nil)
        
    }
}
