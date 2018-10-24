import UIKit

class TodoViewController : UITableViewController {
    var todoStore = TodoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todoTasks = [Todo(name: "Go to the gym"), Todo(name: "Do homework"), Todo(name: "Buy milk")]
        let doneTasks = [Todo(name: "Watch a movie")]
        todoStore.todos = [todoTasks, doneTasks]
    }
    
    
}


// Datasource
extension TodoViewController {
    
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
