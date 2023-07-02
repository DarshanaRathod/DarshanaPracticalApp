//
//  LoginVC.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK:- Validation
    func validate() -> Bool {
        if txtEmail.text!.isEmpty{
            showAlert(message: LabelsList.shared.MSG_LOGIN_ENTER_MOBILE_NUMBER)
        }else if txtPassword.text!.isEmpty{
            showAlert(message: LabelsList.shared.MSG_LOGIN_ENTER_PASSWORD)
        }else{
            return true
        }
        return false
    }
    
    
    // MARK: - Button Action
    @IBAction func btnSignupAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLoginAction(_ sender: UIButton) {
        if validate(){
            SignInAPI()
        }
    }
}
