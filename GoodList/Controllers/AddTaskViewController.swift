//
//  AddTaskViewController.swift
//  GoodList
//
//  Created by DONGGUN LEE on 10/29/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        
        guard let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex),
            let title = taskTitleTextField.text else{
            return
        }
        
        let task = Task(title: title, priority: priority)
        
    }
    
}
