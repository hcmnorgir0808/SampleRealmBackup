//
//  ViewController.swift
//  SampleRealmBackup
//
//  Created by 岩本康孝 on 2024/01/20.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let user = User(name: "iwamoto", age: 26)

        do {
            let realm = try Realm()
            try realm.write {
                realm.add(user, update: .modified)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    @IBAction func tapBackupButton(_ sender: Any) {
        do {
            let realm = try Realm()
            let fileName = "backup.realm"
            try realm.write {
                let fileURL = AppConstant.documentsURL.appendingPathComponent(fileName)
                if FileManager.default.fileExists(atPath: fileURL.path) {
                    try FileManager.default.removeItem(at: fileURL)
                }
                try realm.writeCopy(toFile: AppConstant.documentsURL.appendingPathComponent(fileName))
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    @IBAction func tapRestoreButton(_ sender: Any) {
        do {
            guard let fileURL = Realm.Configuration.defaultConfiguration.fileURL
            else { return }
            // default.realmの位置がある

            let restorePath = AppConstant.documentsURL.appendingPathComponent("backup.realm")
            //            try FileManager.default.removeItem(at: restorePath)
            if FileManager.default.fileExists(atPath: restorePath.path) {

                // バックアップがあれば既存のdefault.realmを削除してrestorePathをfileURLにコピーする
                try FileManager.default.removeItem(at: fileURL)
                try FileManager.default.copyItem(at: restorePath, to: fileURL)
            }
        } catch {
            print("\(error.localizedDescription)")
        }
    }
}
