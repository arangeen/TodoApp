import UIKit

class TodoViewController : UITableViewController {
    var todoStore: TodoStore!  // promising that TodoStore will be initalized or else app crashes
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        //setting up our alert controller
        let alertController = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)
        
        //set up actions to alert controller
        let addAction = UIAlertAction(title: "Add", style: .default){ _ in
            
            //grabbing text field text
            guard let name = alertController.textFields?.first?.text else {return}
            
            // creating newTask
            let newTask = Todo(name: name)
            
            // add Task to taskStore
            self.todoStore.add(newTask, at: 0)
            
            //reload data in table view
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
        addAction.isEnabled = false // so user cant click add button because it is empty
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        //add the text field to alert controller
        alertController.addTextField{ textField in
            textField.placeholder = "Enter to-do name..."
            textField.addTarget(self, action: #selector (self.handleTextChanged), for: .editingChanged)
        }
        
        //add the actions to the alert controller
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        //present the alert controller
        present(alertController, animated: true)
        
    }
    
    @objc private func handleTextChanged(_ sender: UITextField){
        guard let alertController = presentedViewController as? UIAlertController,
              let addAction = alertController.actions.first,
              let text = sender.text
            else {return}
        
        //enabling add action based on if text is empty: returns true if string is empty
        addAction.isEnabled = !text.trimmingCharacters(in: .whitespaces).isEmpty
        
    }
    
}


// MARK: - Datasource
extension TodoViewController {
    // title of sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Uncompleted-Tasks" : "Completed-Tasks"
    }
    
  
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return todoStore.todos.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoStore.todos[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = todoStore.todos[indexPath.section][indexPath.row].name
        return cell
    }
}

//MARK: - Delegate
extension TodoViewController {
    
    // height of sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }
    
    // trailing is swiping from right side of screen (deleteAction)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, sourceView, completionHandler ) in
            
            //determine whether task 'isDone'
            let isDone = self.todoStore.todos[indexPath.section][indexPath.row].isDone
            
            //remove the task from the approproate array
            self.todoStore.remove(at: indexPath.row, isDone: isDone) 
            
            //reload tableview
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //indicate that the action was performed
            completionHandler(true)
        }
    
        //set picture of delete action & background color & return it
      
        deleteAction.image = UIImage(named: "delete")
        deleteAction.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
        
        
    }
    
    // leading is swiping from left side of screen (doneAction)
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let doneAction = UIContextualAction(style: .normal, title: nil) { (action, sourceView, completionHandler) in
            
            // toggle that the task is done
        //   self.todoStore.todos[0][indexPath.row].isDone = true
            
            //remove task form array containing todoTasks
            let doneTask = self.todoStore.remove(at: indexPath.row)
            
            //reload the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            //add the task to the array containing done tasks
            self.todoStore.add(doneTask, at: 0, isDone: true)
            
            //reload table view
            tableView.insertRows(at: [IndexPath.init(row: 0, section: 1)], with: .automatic)
           
            
            //indicate the action was performed
            completionHandler(true)
            
        }
        
        doneAction.image = UIImage(named: "done")
        doneAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        
        // using ternary operator to make sure you can only mark first seciton as done
        return indexPath.section == 0 ? UISwipeActionsConfiguration(actions: [doneAction]) : nil
        
        
    }
    
    
}
