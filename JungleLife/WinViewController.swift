//
//  WinViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/17.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation

class WinViewController: UIViewController,UITextFieldDelegate {

    
    //CoreData
    var context:NSManagedObjectContext!
    let appDel = UIApplication.shared.delegate as! AppDelegate
    
    var myData:[(name:String,score:String,id:String,level:String)] = []
    
    var myJsonData:[(name:String,score:String,id:String,level:String)] = []
    
    var tmpId = ""
    var idHave = false
    var isBest = false
    
    var audioPlayer: AVAudioPlayer!
    
    var myLevel = ""
    var lastScore = ""
    
    var gameName = ""
    var myName = ""
    
    var myTime = 0
    var myCount = 0
    var myId = ""
    
    var deleteId = ""
    
    var reduceCount = 0
    var winOrNot = false
    @IBOutlet weak var winBg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var vEffect: UIView!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var textField1: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: "winM", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        //CoreData
        
        context = appDel.persistentContainer.viewContext
        
        
        if winOrNot == true {
            winBg.image = UIImage(named: "winBg")
            timeLabel.text = String(myTime)
            scoreLabel.text = String((myCount*1000)+((10-reduceCount)*1000)+(600-myTime))
        } else {
            winBg.image = UIImage(named: "loseBg")
            timeLabel.text = String(myTime)
            scoreLabel.text = String((myCount*1000)+((10-reduceCount)*1000)+(600-myTime))
        }
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData = []
        myJsonData = []
        switch gameName {
        case "Game1":
            let allItems = try! context.fetch(MyScore.fetchRequest())
            
            for item in allItems as! [MyScore]
            {
                
                myData.append((item.name!,item.score!,item.id!,item.level!))
                
            }
            
            checkLevel()
            
            //json
            json(str: "https://sheetdb.io/api/v1/ammj39o4i2wja")
            
            break
            
            
        case "Game2":
            let allItems = try! context.fetch(MyScore2.fetchRequest())
            
            for item in allItems as! [MyScore2]
            {
                
                myData.append((item.name!,item.score!,item.id!,item.level!))
                
            }
            
            checkLevel()
            
            //json
            json(str: "https://sheetdb.io/api/v1/doe7udumc9qsh")
            
            break
            
        case "Game3":
            let allItems = try! context.fetch(MyScore3.fetchRequest())
            
            for item in allItems as! [MyScore3]
            {
                
                myData.append((item.name!,item.score!,item.id!,item.level!))
                
            }
            
            checkLevel()
            
            //json
            json(str: "https://sheetdb.io/api/v1/yidip89pry1u5")
            
            break
            
        default:
            
            
            break
            
        }
        
        
        
        
        myData = myData.sorted(by: {$0.score > $1.score})
        
        if myData.count == 0 {
            lastScore = "0"
        } else if myData.count < 10{
            lastScore = (myData.last?.score)!
        } else {
            lastScore = myData[9].score
        }
        
        
        
        
 
    }
    
    struct Information {
        var name : String
        var score : String
        var id : String
        var level : String
    }
    
    func update() {
       
        
        
        switch myLevel {
        case "Eazy":
            myJsonData = myJsonData.filter({ (arg0) -> Bool in
                
                let (_, _, _, level) = arg0
                return level == "Easy"
            })
            break
        case "Medium":
            myJsonData = myJsonData.filter({ (arg0) -> Bool in
                
                let (_, _, _, level) = arg0
                return level == "Medium"
            })
            break
        case "Hard":
            myJsonData = myJsonData.filter({ (arg0) -> Bool in
                
                let (_, _, _, level) = arg0
                return level == "Hard"
            })
            break
        default:
            
            break
            
        }
        
        myJsonData = myJsonData.sorted(by: {$0.score > $1.score})
        
    }
    
    func json(str: String) {
        //json
        let urlStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
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
                    
                }
            }
            
            
            
        }
        
        task.resume() // 開始在背景下載資料
    }
    
    @IBAction func calHome(_ sender: UIButton) {
        
        if winOrNot == true {
            
            if myData.count >= 10 {
                if (Int(scoreLabel.text!)! > Int(lastScore)!) {
                    
                    vEffect.frame = view.frame
                    view.addSubview(vEffect)
                    
//                    let xPosition = myView.frame.origin.x + 166
//
//                    let yPosition = myView.frame.origin.y + 40
//
//                    let height = myView.frame.size.height
//                    let width = myView.frame.size.width
//                    myView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
                    myView.center = view.center
                    view.addSubview(myView)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
                    present(vc, animated: true, completion: nil)
                }
            } else {
                vEffect.frame = view.frame
                view.addSubview(vEffect)
                
//                let xPosition = myView.frame.origin.x + 166
//
//                let yPosition = myView.frame.origin.y + 40
//
//                let height = myView.frame.size.height
//                let width = myView.frame.size.width
//                myView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
                myView.center = view.center
                view.addSubview(myView)
            }
            
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
            present(vc, animated: true, completion: nil)
        }
       
    }
    
    @IBAction func calSend(_ sender: UIButton) {
        myName = textField1.text!
        myId = String(arc4random_uniform(10000)) + scoreLabel.text!
        
        switch gameName {
        case "Game1":
            
            //先去除第十位
            
            if myData.count >= 10 {
                deleteId = myData[9].id
                let fetchRepuest:NSFetchRequest<MyScore>=MyScore.fetchRequest()
                let predicate = NSPredicate(format: "id = '\(deleteId)'")
                fetchRepuest.predicate = predicate
                let allusers = try! context.fetch(fetchRepuest)
                context.delete(allusers[0])
                appDel.saveContext()
            }
            
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore", into: context) as! MyScore
            
            
            
            if myName != ""
            {
                user.name = myName
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel.saveContext()
            
            //post
            postJson(str: "https://sheetdb.io/api/v1/ammj39o4i2wja")
            break
        case "Game2":
            
            //先去除第十位
            if myData.count >= 10 {
                deleteId = myData[9].id
                let fetchRepuest:NSFetchRequest<MyScore2>=MyScore2.fetchRequest()
                let predicate=NSPredicate(format: "id = '\(deleteId)'")
                fetchRepuest.predicate=predicate
                let allusers = try! context.fetch(fetchRepuest)
                context.delete(allusers[0])
                appDel.saveContext()
            }
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore2", into: context) as! MyScore2
            
            if myName != ""
            {
                user.name = myName
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel.saveContext()
            
            //post
            postJson(str: "https://sheetdb.io/api/v1/doe7udumc9qsh")
            break
        case "Game3":
            
            //先去除第十位
            if myData.count >= 10 {
                deleteId = myData[9].id
                let fetchRepuest:NSFetchRequest<MyScore3>=MyScore3.fetchRequest()
                let predicate=NSPredicate(format: "id = '\(deleteId)'")
                fetchRepuest.predicate=predicate
                let allusers = try! context.fetch(fetchRepuest)
                context.delete(allusers[0])
                appDel.saveContext()
            }
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore3", into: context) as! MyScore3
            
            if myName != ""
            {
                user.name = myName
            } else {
                user.name = "No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel.saveContext()
            
            //post
            postJson(str: "https://sheetdb.io/api/v1/yidip89pry1u5")
            break
        default:
            break
        }

        
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
        present(vc, animated: true, completion: nil)
    }
    
    
    
    func checkLevel() {
        
        switch myLevel {
        case "Eazy":
            myData = myData.filter({ (arg0) -> Bool in
                
                let (_, _, _, level) = arg0
                return level == "Easy"
            })
            break
        case "Medium":
            myData = myData.filter({ (arg0) -> Bool in
                
                let (_, _, _, level) = arg0
                return level == "Medium"
            })
            break
        case "Hard":
            myData = myData.filter({ (arg0) -> Bool in
                
                let (_, _, _, level) = arg0
                return level == "Hard"
            })
            break
        default:
            
            break
            
        }
    }
    
    
    func reloadMyData() {
        //先清空 否則會堆疊
        myData = []
        switch gameName {
        case "Game1":
            let allItems = try! context.fetch(MyScore.fetchRequest())
            
            for item in allItems as! [MyScore]
            {
                
                myData.append((item.name!,item.score!,item.id!,item.level!))
                
            }
            
            checkLevel()
            
            
            break
            
            
        case "Game2":
            let allItems = try! context.fetch(MyScore2.fetchRequest())
            
            for item in allItems as! [MyScore2]
            {
                
                myData.append((item.name!,item.score!,item.id!,item.level!))
                
            }
            
            checkLevel()
            
            
            break
            
        case "Game3":
            let allItems = try! context.fetch(MyScore3.fetchRequest())
            
            for item in allItems as! [MyScore3]
            {
                
                myData.append((item.name!,item.score!,item.id!,item.level!))
                
            }
            
            checkLevel()
            
            break
            
        default:
            
            
            break
            
        }

        myData = myData.sorted(by: {$0.score > $1.score})
    }
    
    func postJson(str: String) {
       
        //先抓舊id
        if myData.count != 0 || myJsonData.count != 0 {
            for item in myJsonData {
                if item.id == myData[0].id {
                    tmpId = item.id
                    idHave = true
                    break
                }
            }
        }
        print(tmpId)
        print(idHave)
        
        //重新載入
        reloadMyData()
        if myData[0].id == myId {
            isBest = true
        }
        

        //如果web端沒有本地資料
        if idHave == false {
            //post
            post(str: str)

        } else {
            //如果web端有本地資料,而且有本地新資料要上傳
            if isBest == true {
                //data刪除
                let url2 = URL(string: str + "/Id/\(tmpId)")
                var request2 = URLRequest(url: url2!)
                
                request2.httpMethod = "DELETE"
                request2.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                
                
                
                let task2 = URLSession.shared.dataTask(with: request2) { (data, response, error) in
                    if let error = error {
                        print("error:", error)
                        return
                    }
                    if let data = data {
                        let html = String(data: data, encoding: .utf8)
                        print("Already delete:\(html!)")
                    }
                }
                task2.resume()
                
                //post
                post(str: str)
            }
            
        }
        
        
    }
    
    func post(str: String) {
        var tmpName = ""
        if myName != ""
        {
            tmpName = myName
        }else{
            tmpName = "No name"
        }
        
        let json:[String:String] = ["Name": tmpName, "Score": scoreLabel.text!, "Id": myId,"Level": myLevel]
        let postData:[String:Any] = ["data":json]
        
        
        let url = URL(string: str)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
            let data = try JSONSerialization.data(withJSONObject: postData, options: []) // 將Data轉為JSON格式
            let task = URLSession.shared.uploadTask(with: request, from: data) { (data, response, error) in // 背景上傳資料
                do {
                    
                    guard let data = data else { return }
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else { return }
                    
                    print("json:", json)
                } catch {
                    
                    print("error:", error)
                }
            }
            task.resume()
            
        } catch{
            print(error)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField1.resignFirstResponder()
        return true
    }
    //限制長度為10
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        return newLength <= 10
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
