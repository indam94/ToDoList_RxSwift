//
//  TaskViewController.swift
//  GoodList
//
//  Created by DONGGUN LEE on 10/29/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var toboTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    private var tasks = Variable<[Task]>([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskViewController else{
                fatalError("Controller Not Found")
        }
        
        addTVC.taskSubjectObserable.subscribe(onNext: {task in
            
            print(task)
            self.tasks.value.append(task)
            
            }).disposed(by: disposeBag)
    }
    

    
}
