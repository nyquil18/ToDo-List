//
//  ToDoTableViewController.swift
//  ToDo List
//
//  Created by Nicole Moguel on 7/13/20.
//  Copyright © 2020 Nicole Moguel. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    func getToDos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                if let theToDos = coreDataToDos {
                    toDos = theToDos
                    tableview.reloadData()
                }
            }
            
        }
        
    }
    
    var toDos: [ToDoCD] = []

    override func viewWillAppear(_ animated: Bool) {
        getToDos()
        }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let toDo = toDos[indexPath.row]
       
        
        if let name = toDo.name {
            if toDo.important { cell.textLabel?.text = "❗️" + name
        } else {
            cell.textLabel?.text = toDo.name
        }
      }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toDo = toDos [indexPath.row]
        
        performSegue(withIdentifier: "moveToComplete", sender: toDo)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController{
            addVC.previousVC = self
        }

        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD{
            completeVC.selectedToDo = toDo
            completeVC.previousVC = self
            }
    }

}
}
