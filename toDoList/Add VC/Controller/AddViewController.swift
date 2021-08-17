//
//  AddViewController.swift
//  toDoList
//
//  Created by MacOS on 16/08/2021.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController, UITextViewDelegate {
    
    let realm = try! Realm()
    @IBOutlet weak var textField: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add to Do"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveData))
        textField.autocorrectionType = .no
        textField.delegate = self
        
    }
    
    @objc func saveData(){
        navigationController?.popViewController(animated: true)
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let dateTimeString = formatter.string(from: currentDateTime)
        let textToDo = toDoModel()
        textToDo.toDoText = textField.text ?? ""
        textToDo.date = dateTimeString
        print(textToDo.id)
        try! realm.write {
            realm.add(textToDo)
        }
        
    }
    
    
    
    @IBAction func deleteData(_ sender: Any) {
        try! realm.write(){
            realm.delete(realm.objects(toDoModel.self))
        }
    }
    
    
    
    
}




