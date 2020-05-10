//
//  InputViewController.swift
//  taskapp
//
//  Created by 井上真悠子 on 2020/05/09.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import UIKit

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
