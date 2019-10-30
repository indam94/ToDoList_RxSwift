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
import RxCocoa

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var toboTableView: UITableView!
    
    let disposeBag = DisposeBag()
    
//    private var tasks = Variable<[Task]>([])
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskViewController else{
                fatalError("Controller Not Found")
        }
        
        addTVC.taskSubjectObserable.subscribe(onNext: { [unowned self] task in
            
            print(task)
            
            let priority = Priority(rawValue: self.prioritySegmentControl.selectedSegmentIndex - 1)
            
            var existingTasks = self.tasks.value
            existingTasks.append(task)
            self.tasks.accept(existingTasks)
            
            self.filterTasks(by: priority)
            
            }).disposed(by: disposeBag)
    }
    
    private func filterTasks(by priority: Priority?){
        
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        }
        else{
            self.tasks.map{ tasks in
                return tasks.filter{ $0.priority == priority! }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                
                self?.updateTableView()
                
            }).disposed(by: disposeBag)
        }
        
    }
    
    private func updateTableView(){
        DispatchQueue.main.async {
            self.toboTableView.reloadData()
        }
    }

    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {
        
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        
        filterTasks(by: priority)
    }
    
}
