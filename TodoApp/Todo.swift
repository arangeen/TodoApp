import Foundation

class Todo {
    let name : String
    let isDone : Bool
    
    init(name: String, isDone: Bool = false) {
        self.name = name
        self.isDone = isDone
    }
}
