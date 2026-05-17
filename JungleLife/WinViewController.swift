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
    var appDel: AppDelegate? {
        UIApplication.shared.delegate as? AppDelegate
    }
    
    var myData:[(name:String,score:String,id:String,level:String)] = []
    
    var myJsonData:[(name:String,score:String,id:String,level:String)] = []
    
    var tmpId = ""
    var idHave = false
    var isBest = false
    
    var audioPlayer: AVAudioPlayer?
    
    var myLevel = ""
    var lastScore = ""
    
    var gameName = ""
    var myName = ""
    
    var myTime = 0
    var myCount = 0
    var myId = ""
    
    var deleteId = ""
    var hasNavigated = false
    var isSubmittingScore = false
    
    var reduceCount = 0
    var winOrNot = false
    @IBOutlet weak var winBg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var vEffect: UIView!
    @IBOutlet var myView: UIView!
    @IBOutlet weak var textField1: UITextField!
    
    var currentScore: Int {
        return (myCount * 1000) + ((10 - reduceCount) * 1000) + max(0, 600 - myTime)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = Bundle.main.url(forResource: "winM", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
        //CoreData
        
        guard let appDel else { return }
        context = appDel.persistentContainer.viewContext
        textField1.delegate = self
        
        
        if winOrNot == true {
            winBg.image = UIImage(named: "winBg")
            timeLabel.text = String(myTime)
        } else {
            winBg.image = UIImage(named: "loseBg")
            timeLabel.text = String(myTime)
        }
        scoreLabel.text = String(currentScore)
        
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        audioPlayer?.stop()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        audioPlayer?.play()
        reloadLeaderboardData()
    }
    
    struct Information {
        var name : String
        var score : String
        var id : String
        var level : String
    }
    
    func update() {
        myJsonData = filteredScores(myJsonData)
        myJsonData = myJsonData.sorted(by: { numericScore(for: $0.score) > numericScore(for: $1.score) })
    }
    
    func json(str: String) {
        //json
        guard let urlStr = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: urlStr) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error:", error)
                return
            }
            if let data = data, let content = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{ // 因為資料的Json的格式為陣列（Array）包物件（Object），所以[[String: Any]]
                var remoteData:[(name:String,score:String,id:String,level:String)] = []
                for p in content {
                    guard let name = p["Name"] as? String,
                          let score = p["Score"] as? String,
                          let id = p["Id"] as? String,
                          let level = p["Level"] as? String else { continue }
                    let information = Information(name: name, score: score, id: id, level: level)
                    remoteData.append((information.name, information.score, information.id, information.level))
                }
                
                DispatchQueue.main.async {  // UI的更新必須在Main thread
                    self.myJsonData = remoteData
                    self.update()
                }
            }
        }
        
        task.resume() // 開始在背景下載資料
    }
    
    @IBAction func calHome(_ sender: UIButton) {
        guard !hasNavigated else { return }
        
        if winOrNot == true {
            
            if myData.count >= 10 {
                if currentScore > localThresholdScore() {
                    
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
                    navigateToMenu()
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
            navigateToMenu()
        }
       
    }
    
    @IBAction func calSend(_ sender: UIButton) {
        guard !isSubmittingScore else { return }
        isSubmittingScore = true
        sender.isEnabled = false
        myName = (textField1.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        myId = String(arc4random_uniform(10000)) + scoreLabel.text!
        
        switch gameName {
        case "Game1":
            
            //先去除第十位
            
            if myData.count >= 10 {
                deleteId = myData[9].id
                let fetchRepuest:NSFetchRequest<MyScore>=MyScore.fetchRequest()
                let predicate = NSPredicate(format: "id = '\(deleteId)'")
                fetchRepuest.predicate = predicate
                do {
                    let allusers = try context.fetch(fetchRepuest)
                    if let user = allusers.first {
                        context.delete(user)
                        appDel?.saveContext()
                    }
                } catch {
                    print("Error:", error.localizedDescription)
                }
            }
            
            //CoreData取得表單列表
            guard let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore", into: context) as? MyScore else { return }
            
            
            
            if myName != ""
            {
                user.name = myName
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel?.saveContext()
            
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
                do {
                    let allusers = try context.fetch(fetchRepuest)
                    if let user = allusers.first {
                        context.delete(user)
                        appDel?.saveContext()
                    }
                } catch {
                    print("Error:", error.localizedDescription)
                }
            }
            //CoreData取得表單列表
            guard let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore2", into: context) as? MyScore2 else { return }
            
            if myName != ""
            {
                user.name = myName
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel?.saveContext()
            
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
                do {
                    let allusers = try context.fetch(fetchRepuest)
                    if let user = allusers.first {
                        context.delete(user)
                        appDel?.saveContext()
                    }
                } catch {
                    print("Error:", error.localizedDescription)
                }
            }
            //CoreData取得表單列表
            guard let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore3", into: context) as? MyScore3 else { return }
            
            if myName != ""
            {
                user.name = myName
            } else {
                user.name = "No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel?.saveContext()
            
            //post
            postJson(str: "https://sheetdb.io/api/v1/yidip89pry1u5")
            break
        default:
            break
        }

        
        
        
        navigateToMenu()
    }
    
    
    
    func checkLevel() {
        myData = filteredScores(myData)
    }
    
    
    func reloadMyData() {
        //先清空 否則會堆疊
        myData = []
        loadLocalScores()
        myData = filteredScores(myData)
        myData = myData.sorted(by: { numericScore(for: $0.score) > numericScore(for: $1.score) })
    }
    
    func postJson(str: String) {
        tmpId = ""
        idHave = false
        isBest = false
       
        //先抓舊id
        if !myData.isEmpty && !myJsonData.isEmpty {
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
        if let bestLocalId = myData.first?.id, bestLocalId == myId {
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
        let currentCharacterCount = textField.text?.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 10
    }
    
    private func reloadLeaderboardData() {
        myData = []
        myJsonData = []
        loadLocalScores()
        myData = filteredScores(myData)
        myData = myData.sorted(by: { numericScore(for: $0.score) > numericScore(for: $1.score) })
        lastScore = String(localThresholdScore())
        if let endpoint = endpointURLString() {
            json(str: endpoint)
        }
    }
    
    private func endpointURLString() -> String? {
        switch gameName {
        case "Game1":
            return "https://sheetdb.io/api/v1/ammj39o4i2wja"
        case "Game2":
            return "https://sheetdb.io/api/v1/doe7udumc9qsh"
        case "Game3":
            return "https://sheetdb.io/api/v1/yidip89pry1u5"
        default:
            return nil
        }
    }
    
    private func filteredScores(_ scores: [(name:String,score:String,id:String,level:String)]) -> [(name:String,score:String,id:String,level:String)] {
        let targetLevel: String
        switch myLevel {
        case "Eazy":
            targetLevel = "Easy"
        case "Medium":
            targetLevel = "Medium"
        case "Hard":
            targetLevel = "Hard"
        default:
            return scores
        }
        return scores.filter { $0.level == targetLevel }
    }
    
    private func numericScore(for score: String) -> Int {
        return Int(score) ?? 0
    }
    
    private func localThresholdScore() -> Int {
        if myData.isEmpty {
            return 0
        } else if myData.count < 10 {
            return numericScore(for: myData.last?.score ?? "0")
        } else {
            return numericScore(for: myData[9].score)
        }
    }
    
    private func loadLocalScores() {
        switch gameName {
        case "Game1":
            do {
                let allItems = try context.fetch(MyScore.fetchRequest())
                for item in allItems {
                    myData.append((item.name ?? "No name", item.score ?? "0", item.id ?? "", item.level ?? ""))
                }
            } catch {
                print("Error:", error.localizedDescription)
            }
        case "Game2":
            do {
                let allItems = try context.fetch(MyScore2.fetchRequest())
                for item in allItems {
                    myData.append((item.name ?? "No name", item.score ?? "0", item.id ?? "", item.level ?? ""))
                }
            } catch {
                print("Error:", error.localizedDescription)
            }
        case "Game3":
            do {
                let allItems = try context.fetch(MyScore3.fetchRequest())
                for item in allItems {
                    myData.append((item.name ?? "No name", item.score ?? "0", item.id ?? "", item.level ?? ""))
                }
            } catch {
                print("Error:", error.localizedDescription)
            }
        default:
            break
        }
    }
    
    private func navigateToMenu() {
        guard !hasNavigated else { return }
        hasNavigated = true
        audioPlayer?.stop()
        dismissToMenu()
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
