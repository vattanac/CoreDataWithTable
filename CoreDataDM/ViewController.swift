//
//  ViewController.swift
//  CoreDataDM
//
//  Created by Vattanac on 12/6/18.
//  Copyright © 2018 vattanac. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController {

    var arrayList = [Users]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUser()
        retrieveUser()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! UITableViewCell
        cell.textLabel?.text = arrayList[indexPath.row].username
        return cell
    }
    func retrieveUser(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                arrayList.append(data as! Users)
                //arrayList.append(data.value(forKey: "username") as! Users)
//                print(data.value(forKey: "username") as! String)
//                print(data.value(forKey: "age") as! String)
//                print(data.value(forKey: "password") as! String)
            }
            
        } catch {
            
            print("Failed")
        }
    }
    func createUser(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let user = Users(context: context)
        user.setValue("rer ", forKey: "username")
        user.setValue("543", forKey: "password")
        user.setValue("18", forKey: "age")
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        arrayList.append(user)
        
    }


}

