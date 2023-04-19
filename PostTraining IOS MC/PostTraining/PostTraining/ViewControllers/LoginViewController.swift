//
//  LoginViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    var context:NSManagedObjectContext!
    
    private func initialize() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickLogin(_ sender: Any) {
        let username = usernameTxt.text!
        let password = passwordTxt.text!
        
        // request ke core data
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        // coba fetch
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            
            if result.count == 0 {
                print("Login failed!")
                return
            }
            print("Login Success!")
            if let nextView = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                navigationController?.pushViewController(nextView, animated: true)
            }
            
        }
        catch {
            print("Error occured, failed to log in!")
        }
        
    }
    
    /*
     @IBOutlet weak var onClickLogin: UIButton!
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
