//
//  ViewController.swift
//  taskapp
//
//  Created by 井上真悠子 on 2020/05/09.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableview.delegate = self
        tableview.dataSource = self//ViewControllerをデリゲートにする
    }
    
    func tableView(_ tableView: UITableView,numberOfRowsInSection section:Int) -> Int {//データの数（セルの数）を返す
        return 0;
        
    }
    
    func tableView(_ tableView:UITableView,cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier:"Cell",for:indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "cellSegue", sender: nil)
        
    }
    
    func tableView(_ tableView:UITableView,editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        
    }
    
    func tableView(_ tableView:UITableView,commit editingStyle: UITableViewCell.EditingStyle,forRowAt indexPath: IndexPath) {
        
    }



}

