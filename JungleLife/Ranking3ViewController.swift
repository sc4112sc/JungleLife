//
//  Ranking3ViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/20.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import CoreData

class Ranking3ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    var myData:[String:String] = [:]
    
    
    var keyA = [String]()
    var valueA = [String]()
    
    var intA = [Int]()
    
    
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if keyA.count >= 10{
            return 10
        }else{
            return keyA.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Number \(indexPath.row+1).   " + valueA[indexPath.row]
        cell.detailTextLabel?.text = "Score:  " + keyA[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData = [:]
        
        context = appDel.persistentContainer.viewContext
        
        let allItems = try! context.fetch(MyScore3.fetchRequest())
        
        for item in allItems as! [MyScore3]
        {
            
            myData[item.score!] = item.name!
            
        }
        
        
        
        keyA = Array(myData.keys)
        intA = keyA.map {Int($0)!}
        intA.sort(by: {$0 > $1})
        keyA = intA.map {String($0)}
        
        
        if keyA.count == 0 {
            
            keyA.append("0")
            valueA.append("No data yet")
            
        } else {
            
            for i in 0...(keyA.count-1) {
                
                valueA.append(myData[keyA[i]]!)
            }
        }
        
        
        
        //重新載入
        myTableView.reloadData()
    }
    
    @IBAction func calBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
