//
//  User.swift
//  SampleRealmBackup
//
//  Created by 岩本康孝 on 2024/01/21.
//

import RealmSwift
import Foundation

class User: Object {

    @Persisted (primaryKey: true) var id: String = UUID().uuidString

    @Persisted var name: String

    @Persisted var age: Int

    convenience init(name: String, age: Int) {
        self.init()
        self.name = name
        self.age = age
    }
}
