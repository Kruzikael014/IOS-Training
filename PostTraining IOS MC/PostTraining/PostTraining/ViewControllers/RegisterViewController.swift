//
//  RegisterViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var phoneNumTxt: UITextField!
    
    var context:NSManagedObjectContext!
    
    func initialize() {
        let appDelegate = UIApplication.shared
            .delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        let username = usernameTxt.text!
        if (username == "") {
            print("Username cant be empty!")
            return
        }
        let password = passwordTxt.text!
        if (password == "") {
            print("Password cant be empty!")
            return
        }
        let cPass    = confirmPassTxt.text!
        if (cPass == "") {
            print("Confirm Password cant be empty!")
            return
        }
        let email    = emailTxt.text!
        if (email == "") {
            print("Email cant be empty!")
            return
        }
        let phone    = phoneNumTxt.text!
        if (phone == "") {
            print("Phone Number cant be empty!")
            return
        }
        if (cPass.elementsEqual(password)) {
            let entity = NSEntityDescription.entity(forEntityName: "Users", in:context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            newUser.setValue(username, forKey: "username")
            newUser.setValue(password, forKey: "password")
            newUser.setValue(email, forKey: "email")
            newUser.setValue(phone, forKey: "phoneNumber")
            do {
                try context.save()
                print("Account saved successfully!")
                
                if let nextView = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                    navigationController?.pushViewController(nextView, animated: true)
                }
                
            }
            catch {
                print("Unknown error! Failed to insert new account!")
            }
            return
        }
        print("Account cant be registered, make sure you have enter correct password confirmation")
    }
}
