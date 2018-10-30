import Foundation

class TodoStore{
    
    var todos = [[Todo](), [Todo]()]
    
    // adding todo
    func add(_ todo: Todo, at index: Int, isDone: Bool = false){
        
        //if task is done, put in section 1
        let section = isDone ? 1 : 0
        todos[section].insert(todo, at: index)
        
    }
    
    //remove todo
    //@discardableResult will silence the warning we can get
    //"result of call to Remove() is unused"
   @discardableResult func remove (at index: Int, isDone: Bool = false) -> Todo {
        
        let section = isDone ? 1 : 0
        
        return todos[section].remove(at: index)
    }
    
}
