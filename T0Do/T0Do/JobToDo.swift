//
//  JobToDo.swift
//  T0Do
//
//  Created by nju on 2021/10/21.
//

import UIKit

class JobToDo: NSObject {
    
    var title: String
    var isFinished: Bool
    
    init(title:String = "something 2 do", isFinished:Bool = false) {
        self.title = title
        self.isFinished = isFinished
    }

}
