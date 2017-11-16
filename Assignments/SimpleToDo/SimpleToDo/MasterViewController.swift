//
//  MasterViewController.swift
//  SimpleToDo
//
//  Created by MINA FUJISAWA on 2017/10/17.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
//    var objects = [AnyObject]()
    var todos = ToDoList.getToDoList()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                        action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
    }


    @objc func insertNewObject(_ sender: AnyObject) {
//        todos.insert(NSDate(), at: 0)
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath as IndexPath], with: .automatic)
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let todo = todos[indexPath.row]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = todo
            }
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TodoCell

        let todo = todos[indexPath.row]
        cell.titleLabel.text = todo.title
        cell.descLabel.text = todo.desc
        cell.priorityLabel.text = String(todo.priority)
        
        //TODO : strikethrough text of all other text if the task is completed
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

