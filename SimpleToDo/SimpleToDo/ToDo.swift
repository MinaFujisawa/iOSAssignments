//
//  ToDo.swift
//  SimpleToDo
//
//  Created by MINA FUJISAWA on 2017/10/17.
//  Copyright © 2017 MINA FUJISAWA. All rights reserved.
//

import Foundation
class ToDo {
    var title: String
    var desc: String?
    var priority: Int
    var isCompleted: Bool

    init(title: String, desc: String?, priority: Int, isCompleted: Bool) {
        self.title = title
        self.desc = desc
        self.priority = priority
        self.isCompleted = isCompleted
    }
}

struct ToDoList {
    static func getToDoList() -> [ToDo] {
        let todo1 = ToDo(title: "Wash dishes", desc: "Make sure you use new dish soap" , priority: 3, isCompleted: false)
        let todo2 = ToDo(title: "Write Essay", desc: "long text long textlong textlong textlong text" , priority: 1, isCompleted: false)
        let todo3 = ToDo(title: "Clean desk", desc: nil , priority: 2, isCompleted: true)
        
        return [todo1, todo2, todo3]
    }
}
