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
    
    var myData:[String:String] = [:]
    
    var keyA = [String]()
    
    var audioPlayer: AVAudioPlayer!
    
    var myLevel = ""
    var lastScore = ""
    
    var gameName = ""
    var myName = ""
    
    var myTime = 0
    var myCount = 0
    var myScore = 0
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
            scoreLabel.text = String((myScore*1000)+((10-reduceCount)*1000)+(600-myTime))
        } else {
            winBg.image = UIImage(named: "loseBg")
            timeLabel.text = String(myTime)
            scoreLabel.text = String((myScore*1000)+((10-reduceCount)*1000)+(600-myTime))
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    override func viewDidAppear(_ animated: Bool) {
        //先清空 否則會堆疊
        myData = [:]
        
        switch gameName {
        case "Game1":
            let allItems = try! context.fetch(MyScore.fetchRequest())
            
            for item in allItems as! [MyScore]
            {
                
                myData[item.score!] = item.name!
                
            }
            
            break
            
            
        case "Game2":
            let allItems = try! context.fetch(MyScore2.fetchRequest())
            
            for item in allItems as! [MyScore2]
            {
                
                myData[item.score!] = item.name!
                
            }
            
            break
            
        case "Game3":
            let allItems = try! context.fetch(MyScore3.fetchRequest())
            
            for item in allItems as! [MyScore3]
            {
                
                myData[item.score!] = item.name!
                
            }
            
            break
            
        default:
            
            
            break
            
        }
        
        
        
        
        keyA = Array(myData.keys).sorted(by: { (a, b) -> Bool in
            a > b
        })
        
        if keyA.last == nil {
            lastScore = "0"
        } else {
            lastScore = keyA.last!
        }
        
        
        
    }
    
    @IBAction func calHome(_ sender: UIButton) {
        
        if winOrNot == true {
            
            if keyA.count >= 10 {
                if (myScore > Int(lastScore)!) {
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
        
        
        switch gameName {
        case "Game1":
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore", into: context) as! MyScore
            
            if myName != ""
            {
                user.name = myName + "     Level:  \(myLevel)"
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            
            appDel.saveContext()
            break
        case "Game2":
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore2", into: context) as! MyScore2
            
            if myName != ""
            {
                user.name = myName + "     Level:  \(myLevel)"
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            
            appDel.saveContext()
            break
        case "Game3":
            //CoreData取得表單列表
            let user = NSEntityDescription.insertNewObject(forEntityName: "MyScore3", into: context) as! MyScore3
            
            if myName != ""
            {
                user.name = myName + "     Level:  \(myLevel)"
            }else{
                user.name = "No name"
            }
            user.score = scoreLabel.text
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
