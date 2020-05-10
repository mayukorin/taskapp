//
//  Task.swift
//  taskapp
//
//  Created by 井上真悠子 on 2020/05/10.
//  Copyright © 2020 taro.kirameki. All rights reserved.
//

import RealmSwift

class Task: Object {
    @objc dynamic var id = 0
    
    @objc dynamic var title = ""
    
    @objc dynamic var date = Date()
    
    @objc dynamic var contents = ""
    
    @objc dynamic var category = ""//カテゴリーを追加
    
    override static func primaryKey() -> String {
        return "id"
    }
}
