import UIKit

class TodoViewController : UITableViewController {
    var todoStore: TodoStore!  // promising that TodoStore will be initalized or else app crashes
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addTodo(_ sender: UIBarButtonItem) {
        //setting up our alert controller
        let alertController = UIAlertController(title: "Add todo", message: nil, preferredStyle: .alert)
        
        //set up actions to alert controller
        let addAction = UIAlertAction(title: "Add", style: .default, handler: nil)
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


// Datasource
extension TodoViewController {
    // title of sections
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Uncompleted-Tasks" : "Completed-Tasks"
    }
    
    // height of sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
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
