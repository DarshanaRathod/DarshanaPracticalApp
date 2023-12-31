//
//  SignupVC.swift
//  DarshanaDRCPractical
//
//  Created by Ravi on 02/07/23.
//

import UIKit
import CoreData

class SignupVC: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNo: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignup: UIButton!
    
    var context:NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        }else if txtConfirmPassword.text!.isEmpty{
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
        if validate(){
            fetchData()
        }
    }
    
    /// Fetch data for Check user email already added or not
    func fetchData(){
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if(result.isEmpty){
                self.openDatabse(email: txtEmail.text!, password:txtPassword.text!)
                self.navigationController?.popViewController(animated: true)
            }
            for data in result as! [NSManagedObject] {
                let email = data.value(forKey: "email") as! String
                if(txtEmail.text == email ){
                    showToast(message: "Email already Added")
                }else{
                    self.openDatabse(email: txtEmail.text!, password:txtPassword.text!)
                    self.navigationController?.popViewController(animated: true)
                }
                break
            }
        } catch {
            print("Fetching data Failed")
        }
    }
    
    
}




//MARK: Functions
extension SignupVC{
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
    }
    func deleteAllData(entity: String){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do{
            let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            for managedObject in results{
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                appDelegate.persistentContainer.viewContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
}

