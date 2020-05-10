//
//  InputViewController.swift
//  taskapp
//
//  Created by 井上真悠子 on 2020/05/09.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet weak var categoryTextField: UITextField!//outletを加える
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var task: Task!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self,action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        titleTextFiled.text = task.title
        contentsTextView.text = task.contents
        categoryTextField.text = task.category//ViewControllerから送られてきた情報を入れる
        datePicker.date = task.date
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        try! realm.write {
            self.task.title = self.titleTextFiled.text!
            self.task.contents = self.contentsTextView.text
            self.task.date = self.datePicker.date
            
            self.task.category = self.categoryTextField.text!//カテゴリーに入力したものを保存する
            self.realm.add(self.task,update: .modified)
            
            
        }
        
        setNotification(task:task)
        super.viewWillDisappear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setNotification(task:Task) {
        let content = UNMutableNotificationContent()
        
        if task.title == "" {
            content.title = "(タイトルなし)"
        } else {
            content.title = task.title
            
        }
        
        if task.contents == "" {
            content.body = "(内容なし)"
        } else {
            content.body = task.contents
        }
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents(([.year,.month,.day,.hour,.minute]), from:task.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: String(task.id),content:content,trigger:trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) {(error) in print(error ?? "ローカル通知登録 OK")}
        
        center.getPendingNotificationRequests { (requests:[UNNotificationRequest]) in
            for request in requests {
                print("/-----------/")
                print(request)
                print("/-----------/")
            }
        }
        
    }

}
