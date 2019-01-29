//
//  RankingViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/19.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import CoreData

class RankingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    var myData:[(name:String,score:String,level:String)] = []
    var myData1:[(name:String,score:String,level:String)] = []
    var myData2:[(name:String,score:String,level:String)] = []
    var myData3:[(name:String,score:String,level:String)] = []
    
    @IBOutlet weak var noText: UILabel!
    @IBOutlet weak var bg2: UIView!
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

        
        if section == 0 {
            if myData1.count >= 10{
                return 10
            }else{
                return myData1.count
            }
        } else if section == 1 {
            if myData2.count >= 10{
                return 10
            }else{
                return myData2.count
            }
        } else {
            if myData3.count >= 10{
                return 10
            }else{
                return myData3.count
            }
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "Number \(indexPath.row+1).   " + myData1[indexPath.row].name
            cell.detailTextLabel?.text = "Score:  " + myData1[indexPath.row].score
            cell.backgroundColor = #colorLiteral(red: 0.6688833237, green: 0.4199428558, blue: 0.2589688897, alpha: 1)
            cell.imageView?.image = UIImage(named:  "Apple1")
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "Number \(indexPath.row+1).   " + myData2[indexPath.row].name
            cell.detailTextLabel?.text = "Score:  " + myData2[indexPath.row].score
            cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cell.imageView?.image = UIImage(named:  "Onion1")
        } else {
            cell.textLabel?.text = "Number \(indexPath.row+1).   " + myData3[indexPath.row].name
            cell.detailTextLabel?.text = "Score:  " + myData3[indexPath.row].score
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.imageView?.image = UIImage(named:  "Steak1")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Easy"
        } else if section == 1 {
            return "Medium"
        } else {
            return "Hard"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData = []
        myData1 = []
        myData2 = []
        myData3 = []

        context = appDel.persistentContainer.viewContext

        let allItems = try! context.fetch(MyScore.fetchRequest())

        for item in allItems as! [MyScore]
        {

            myData.append((item.name!,item.score!,item.level!))
            
        }


        
        myData1 = myData.filter({ (arg0) -> Bool in
            
            let (_, _, level) = arg0
            return level == "Easy"
        })
        
        myData2 = myData.filter({ (arg0) -> Bool in
            
            let (_, _, level) = arg0
            return level == "Medium"
        })
        
        myData3 = myData.filter({ (arg0) -> Bool in
            
            let (_, _, level) = arg0
            return level == "Hard"
        })

        myData1 = myData1.sorted(by: {$0.score > $1.score})
        myData2 = myData2.sorted(by: {$0.score > $1.score})
        myData3 = myData3.sorted(by: {$0.score > $1.score})
        
        //重新載入
        myTableView.reloadData()
        
        if myData.count == 0 {
            bg2.isHidden = false
            noText.isHidden = false
        } else {
            bg2.isHidden = true
            noText.isHidden = true
        }
        
 
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
