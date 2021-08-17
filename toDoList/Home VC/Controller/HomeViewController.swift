//
//  HomeViewController.swift
//  toDoList
//
//  Created by MacOS on 16/08/2021.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    
    let realm = try! Realm()
    
    var toDoArr: [toDoModel] = [toDoModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
        tableView.register(UINib(nibName: "listTBVCell", bundle: nil), forCellReuseIdentifier: "listTBVCell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.toDoArr = self.getToDoData()
        self.tableView.reloadData()
    }
    
    func getToDoData() -> [toDoModel]{
        let dataSave = realm.objects(toDoModel.self)
        var listDataPro:[toDoModel] = [toDoModel]()
        for item in dataSave{
            listDataPro.append(item)
        }
        return listDataPro
    }
    
    @objc func addTapped(){
        let vc = AddViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listTBVCell", for: indexPath) as! listTBVCell
        cell.label.text = toDoArr[indexPath.row].toDoText
        cell.date.text = toDoArr[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write {
                realm.delete(self.toDoArr[indexPath.row])
                self.toDoArr.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        }
    }
    
}

