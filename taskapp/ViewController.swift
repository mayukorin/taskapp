//
//  ViewController.swift
//  taskapp
//
//  Created by 井上真悠子 on 2020/05/09.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var uiSearch: UISearchBar!
    
    var i:Int = 0
    
    let realm = try! Realm()
    
    var taskArray = try! Realm().objects(Task.self).sorted(byKeyPath:"date",ascending:true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.delegate = self
        tableview.dataSource = self//ViewControllerをデリゲートにする
        
        uiSearch.delegate = self//viewControllerをデリゲートにする
        uiSearch.placeholder = "カテゴリーを入力してください"
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?) {
        
        let inputViewController:InputViewController = segue.destination as! InputViewController
        
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableview.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        } else {
            let task = Task()
            
            let allTasks =  realm.objects(Task.self)
            if allTasks.count != 0 {
                
                task.id = allTasks.max(ofProperty:"id")! + 1
                
            }
            inputViewController.task = task
        
        }
        
        
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int) -> Int {//データの数（セルの数）を返す
        
        
       
        
        
        return taskArray.count;
       
        
    }
    
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableview.dequeueReusableCell(withIdentifier:"Cell",for:indexPath)
        
        
        let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from:task.date)
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
        
    }
    
    func tableView(_ tableView:UITableView,editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }

    func tableView(_ tableView:UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
        
        if editingStyle == .delete {
            
            let task = self.taskArray[indexPath.row]
            
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [String(task.id)])
            
            try! realm.write {
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with:.fade) 
            }
            
            center.getPendingNotificationRequests { (requests:[UNNotificationRequest]) in
                for request in requests {
                    print("/-------/")
                    print(request)
                    print("/-------/")
                }
            }
        }
        
    }
    
    //入力画面から戻ってきた時にtableViewを更新させる
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableview.reloadData()
        
    }



}

