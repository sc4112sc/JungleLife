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
    
    var myData:[(name:String,score:String,id:String)] = []
    
    
    
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
        
        myId = String(arc4random_uniform(10000)) + scoreLabel.text!
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData = []
        
        switch gameName {
        case "Game1":
            let allItems = try! context.fetch(MyScore.fetchRequest())
            
            for item in allItems as! [MyScore]
            {
                
                myData.append((item.name!,item.score!,item.id!))
                
            }
            
            break
            
            
        case "Game2":
            let allItems = try! context.fetch(MyScore2.fetchRequest())
            
            for item in allItems as! [MyScore2]
            {
                
                myData.append((item.name!,item.score!,item.id!))
                
            }
            
            break
            
        case "Game3":
            let allItems = try! context.fetch(MyScore3.fetchRequest())
            
            for item in allItems as! [MyScore3]
            {
                
                myData.append((item.name!,item.score!,item.id!))
                
            }
            
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
        
        print(lastScore)
        
        
    }
    
    @IBAction func calHome(_ sender: UIButton) {
        
        if winOrNot == true {
            
            if myData.count >= 10 {
                if (Int(scoreLabel.text!)! > Int(lastScore)!) {
                    
                    vEffect.frame = view.frame
                    view.addSubview(vEffect)
                    
                    let xPosition = myView.frame.origin.x + 166
                    
                    let yPosition = myView.frame.origin.y + 40
                    
                    let height = myView.frame.size.height
                    let width = myView.frame.size.width
                    myView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
                    view.addSubview(myView)
                } else {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
                    present(vc, animated: true, completion: nil)
                }
            } else {
                vEffect.frame = view.frame
                view.addSubview(vEffect)
                
                let xPosition = myView.frame.origin.x + 166
                
                let yPosition = myView.frame.origin.y + 40
                
                let height = myView.frame.size.height
                let width = myView.frame.size.width
                myView.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
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
                let predicate=NSPredicate(format: "id = '\(deleteId)'")
                fetchRepuest.predicate=predicate
                let allusers = try! context.fetch(fetchRepuest)
                context.delete(allusers[0])
                appDel.saveContext()
            }
            
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore", into: context) as! MyScore
            
            
            
            if myName != ""
            {
                user.name = "Challenger: " + myName
            }else{
                user.name = "Challenger: No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel.saveContext()
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
                user.name = "Challenger: " + myName
            }else{
                user.name = "Challenger: No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel.saveContext()
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
                user.name = "Challenger: " + myName
            }else{
                user.name = "Challenger: No name"
            }
            user.score = scoreLabel.text
            user.id = myId
            user.level = myLevel
            appDel.saveContext()
            break
        default:
            break
        }


        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
        present(vc, animated: true, completion: nil)
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
