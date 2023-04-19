//
//  HomeViewController.swift
//  PostTraining
//
//  Created by prk on 19/04/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameTxt: UIsTextField!
    var arrOfInitial = [String]()
    var arrOfNames = [String]()
    @IBOutlet weak var initialTxt: UITextField!
    @IBOutlet weak var assistantTV: UITableView!
    var context: NSManagedObjectContext!
    
    func initialize() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfInitial.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AssistantTableViewCell
        
        cell.initialTxt.text = arrOfInitial[indexPath.row]
        cell.nameTxt.text = arrOfNames[indexPath.row]
        cell.updateHandler = {
            self.updateData(cell : cell, indexPath: indexPath)
        }
        return cell
    }

    // update data
    func updateData(cell: UITableViewCell, indexPath: IndexPath) {
        
    }
    
    // laod data
    func loadData() {
        // clear
        arrOfNames.removeAll()
        arrOfInitial.removeAll()
        
        // masukkin data kedalam array
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Assistants")
        
        do {
            let results = try context.fetch(request) as! [NSManagedObject]
            
            for data in results {
                arrOfInitial.append(data.value(forKey: "initial") as! String)
                arrOfNames.append(data.value(forKey: "name") as! String)
            }
            assistantTV.reloadData()
            print("Data fetched successfully!")
        }
        catch {
            print("Error occured, failed to fetch data!")
        }
    }
    
    func deleteData() {
        
    }
    
    func doInsert() {
        // retrieve from text field
        let name = nameTxt.text!
        let initial = initialTxt.text!
        let entity = NSEntityDescription.entity(forEntityName: "Assistants", in: context)
        let newAssistant = NSManagedObject(entity: entity!, insertInto: context)
        // set value
        newAssistant.setValue(name, forKey: "name")
        newAssistant.setValue(initial, forKey: "initial")
        do {
            try context.save()
            loadData()
            print("Insert success!")
        }
        catch {
            print("Error occured, failed to insert data!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared
            .delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        assistantTV.delegate = self
        assistantTV.dataSource = self
        loadData()
    }
    

    @IBAction func onClickInsert(_ sender: Any) {
        
        doInsert()
        
    }
    
    
    
    /*
     
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
