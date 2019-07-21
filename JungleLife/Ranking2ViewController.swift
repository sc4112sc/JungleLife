//
//  Ranking2ViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/20.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import CoreData
import ViewAnimator

class Ranking2ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    //core data
    var appDel = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    
    var myData:[(name:String,score:String,level:String,id:String)] = []
    var myData1:[(name:String,score:String,level:String,id:String)] = []
    var myData2:[(name:String,score:String,level:String,id:String)] = []
    var myData3:[(name:String,score:String,level:String,id:String)] = []
    
    var myJsonData:[(name:String,score:String,id:String,level:String)] = []
    var myJsonData1:[(name:String,score:String,id:String,level:String)] = []
    var myJsonData2:[(name:String,score:String,id:String,level:String)] = []
    var myJsonData3:[(name:String,score:String,id:String,level:String)] = []

    @IBOutlet weak var mySeg: UISegmentedControl!
    
    @IBOutlet weak var noText: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if rankStatus == false {
            
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
            
        } else {
            
            if section == 0 {
                
                return myJsonData1.count
                
            } else if section == 1 {
                
                return myJsonData2.count
                
            } else {
                
                return myJsonData3.count
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            if rankStatus == false {
                cell.textLabel?.text = "\(indexPath.row+1).   " +  "Challenger : " + myData1[indexPath.row].name + "   Id : " + myData1[indexPath.row].id
                cell.detailTextLabel?.text = "Score:  " + myData1[indexPath.row].score
            } else {
                cell.textLabel?.text = "\(indexPath.row+1).   " +  "Challenger : " + myJsonData1[indexPath.row].name + "   Id : " + myJsonData1[indexPath.row].id
                cell.detailTextLabel?.text = "Score:  " + myJsonData1[indexPath.row].score
            }
            cell.backgroundColor = #colorLiteral(red: 0.6688833237, green: 0.4199428558, blue: 0.2589688897, alpha: 1)
            cell.imageView?.image = UIImage(named:  "Palette1")
        } else if indexPath.section == 1 {
            if rankStatus == false {
                cell.textLabel?.text = "\(indexPath.row+1).   " +  "Challenger : " + myData2[indexPath.row].name + "   Id : " + myData2[indexPath.row].id
                cell.detailTextLabel?.text = "Score:  " + myData2[indexPath.row].score
            } else {
                cell.textLabel?.text = "\(indexPath.row+1).   " +  "Challenger : " + myJsonData2[indexPath.row].name + "   Id : " + myJsonData2[indexPath.row].id
                cell.detailTextLabel?.text = "Score:  " + myJsonData2[indexPath.row].score
            }
            cell.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            cell.imageView?.image = UIImage(named:  "Towel1")
        } else {
            if rankStatus == false {
                cell.textLabel?.text = "\(indexPath.row+1).   " +  "Challenger : " + myData3[indexPath.row].name + "   Id : " + myData3[indexPath.row].id
                cell.detailTextLabel?.text = "Score:  " + myData3[indexPath.row].score
            } else {
                cell.textLabel?.text = "\(indexPath.row+1).   " +  "Challenger : " + myJsonData3[indexPath.row].name + "   Id : " + myJsonData3[indexPath.row].id
                cell.detailTextLabel?.text = "Score:  " + myJsonData3[indexPath.row].score
            }
            cell.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            cell.imageView?.image = UIImage(named:  "Computer1")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       
        if rankStatus == false {
            if myData.count == 0 {
                
                return  nil
                
            } else {
                
                if section == 0 {
                    return "Easy"
                } else if section == 1 {
                    return "Medium"
                } else {
                    return "Hard"
                }
                
                
            }
        } else {
            if myJsonData.count == 0 {
                
                return  nil
                
            } else {
                
                if section == 0 {
                    return "Easy"
                } else if section == 1 {
                    return "Medium"
                } else {
                    return "Hard"
                }
                
                
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    struct Information {
        var name : String
        var score : String
        var id : String
        var level : String
    }
    
    func update() {
        //
        myJsonData1 = []
        myJsonData2 = []
        myJsonData3 = []
        
        myJsonData1 = myJsonData.filter({ (arg0) -> Bool in
            
            let (_, _, _, level) = arg0
            return level == "Easy"
        })
        
        myJsonData2 = myJsonData.filter({ (arg0) -> Bool in
            
            let (_, _, _, level) = arg0
            return level == "Medium"
        })
        
        myJsonData3 = myJsonData.filter({ (arg0) -> Bool in
            
            let (_, _, _, level) = arg0
            return level == "Hard"
        })
        
        myJsonData1 = myJsonData1.sorted(by: {$0.score > $1.score})
        myJsonData2 = myJsonData2.sorted(by: {$0.score > $1.score})
        myJsonData3 = myJsonData3.sorted(by: {$0.score > $1.score})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        myData = []
        
        context = appDel.persistentContainer.viewContext
        
        let allItems = try! context.fetch(MyScore2.fetchRequest())
        
        for item in allItems as! [MyScore2]
        {
            
            myData.append((item.name!,item.score!,item.level!,item.id!))
            
        }
        
//        //
//        myJsonData = []
//        let url = URL(string: "https://sheetdb.io/api/v1/doe7udumc9qsh")
//
//        do {
//            let data = try Data(contentsOf: url!)
//            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
//
//            for p in jsonObj {
//                myJsonData.append((p["Name"] as! String,p["Score"] as! String,p["Id"] as! String,p["Level"] as! String))
//            }
//
//        } catch {
//            print(error.localizedDescription)
//        }
        
        //
        myJsonData = []
        let urlStr = "https://sheetdb.io/api/v1/doe7udumc9qsh".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlStr!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data, let content = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{ // 因為資料的Json的格式為陣列（Array）包物件（Object），所以[[String: Any]]
                
                
                
                
                for p in content {
                    
                    let name = p["Name"] as! String
                    let score = p["Score"] as! String
                    let id = p["Id"] as! String
                    let level = p["Level"] as! String
                    let information = Information(name: name, score: score, id: id, level: level)
                    
                    
                    self.myJsonData.append((information.name, information.score, information.id, information.level))
                    
                }
                
                DispatchQueue.main.async {  // UI的更新必須在Main thread
                    
                    self.update()
                    //重新載入
                    self.myTableView.reloadData()
                }
            }
            
            
            
        }
        
        task.resume() // 開始在背景下載資料
        
    }
    
    let animations = AnimationType.from(direction: .left, offset: 30.0)
    
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
       
        myData1 = []
        myData2 = []
        myData3 = []
        

        
  
        myData1 = myData.filter({ (arg0) -> Bool in
            
            let (_, _, level, _) = arg0
            return level == "Easy"
        })
        
        myData2 = myData.filter({ (arg0) -> Bool in
            
            let (_, _, level, _) = arg0
            return level == "Medium"
        })
        
        myData3 = myData.filter({ (arg0) -> Bool in
            
            let (_, _, level, _) = arg0
            return level == "Hard"
        })
        
        myData1 = myData1.sorted(by: {$0.score > $1.score})
        myData2 = myData2.sorted(by: {$0.score > $1.score})
        myData3 = myData3.sorted(by: {$0.score > $1.score})
        

        
        //重新載入
        mySeg.selectedSegmentIndex = 0
        rankStatus = false
        myTableView.reloadData()
        
        if mySeg.selectedSegmentIndex == 0 {
            if myData.count == 0 {
                
                noText.isHidden = false
            } else {
                
                noText.isHidden = true
            }
        }
        
        UIView.animate(views: myTableView.visibleCells,
                       animations: [animations],
                       delay: 0.5)
       
    }
    
    var rankStatus = false
    
    @IBAction func changeRK(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if myData.count == 0 {
                
                noText.isHidden = false
            } else {
                
                noText.isHidden = true
            }
            
            rankStatus = false
            myTableView.reloadData()
        } else {
            if myJsonData.count == 0 {
                
                noText.isHidden = false
            } else {
                
                noText.isHidden = true
            }
            
            rankStatus = true
            myTableView.reloadData()
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
