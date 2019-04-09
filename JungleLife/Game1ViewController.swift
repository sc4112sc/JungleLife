//
//  Game1ViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/14.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import AVFoundation
//import AudioToolbox

class Game1ViewController: UIViewController {
    
    //
    var timer:Timer! = nil
    
    let time: Double = 0.3
    
    var flakeImage: UIImage!
    //
    
    var audioPlayer: AVAudioPlayer!
    var boyAudioPlayer: AVAudioPlayer!
    var hunterAudioPlayer: AVAudioPlayer!
    
    var mytimer:Timer!
    var mytimer2:Timer!
    var mytimer3:Timer!
    
    var myLevel = ""
    var winOrNot = false
    var boyCount = 0
    var hunterCount = 0
    //時間記數
    var timeCount = 0
    //哪一關
    var gameName = ""
    var naxtGameName = ""
    
    var allIts = [String]()
    var copyAllIts = [String]()
    var fiveAns = [String]()
    var question = ""
    var addIts = ""
    
    var boyAry = [UIImage(named: "boy1"),UIImage(named: "boy2"),UIImage(named: "boy3")]
    var hunterAry = [UIImage(named: "hunter1"),UIImage(named: "hunter2"),UIImage(named: "hunter3")]
    
    var boomImgsLeft = [UIImage(named: "nilBg1"),UIImage(named: "leftBoom1"),UIImage(named: "leftBoom2"),UIImage(named: "leftBoom3"),UIImage(named: "leftBoom4"),UIImage(named: "leftBoom5"),UIImage(named: "leftBoom6"),UIImage(named: "nilBg1")]
    var boomImgsRight = [UIImage(named: "nilBg1"),UIImage(named: "rightBoom1"),UIImage(named: "rightBoom2"),UIImage(named: "rightBoom3"),UIImage(named: "rightBoom4"),UIImage(named: "rightBoom5"),UIImage(named: "rightBoom6"),UIImage(named: "nilBg1")]
    
    var hunterBloodImgs = [UIImage(named: "hunterB1"),UIImage(named: "hunterB2"),UIImage(named: "hunterB3"),UIImage(named: "hunterB4"),UIImage(named: "hunterB5"),UIImage(named: "hunterB6"),UIImage(named: "hunterB7"),UIImage(named: "hunterB8"),UIImage(named: "hunterB9"),UIImage(named: "hunterB10")]
    var boyBloodImgs = [UIImage(named: "boyB1"),UIImage(named: "boyB2"),UIImage(named: "boyB3"),UIImage(named: "boyB4"),UIImage(named: "boyB5"),UIImage(named: "boyB6"),UIImage(named: "boyB7"),UIImage(named: "boyB8"),UIImage(named: "boyB9"),UIImage(named: "boyB10")]
    
    @IBOutlet weak var boyImg: UIImageView!
    @IBOutlet weak var hunterImg: UIImageView!
    @IBOutlet weak var ans1: UIButton!
    @IBOutlet weak var ans2: UIButton!
    @IBOutlet weak var ans3: UIButton!
    @IBOutlet weak var ans4: UIButton!
    @IBOutlet weak var ans5: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var boomImg: UIImageView!

    @IBOutlet weak var hunterBlood: UIImageView!
    @IBOutlet weak var boyBlood: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        ans1.layer.cornerRadius = 10
        ans1.layer.borderColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        ans1.layer.borderWidth = 2
        
        ans2.layer.cornerRadius = 10
        ans2.layer.borderColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        ans2.layer.borderWidth = 2
        
        ans3.layer.cornerRadius = 10
        ans3.layer.borderColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        ans3.layer.borderWidth = 2
        
        ans4.layer.cornerRadius = 10
        ans4.layer.borderColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        ans4.layer.borderWidth = 2
        
        ans5.layer.cornerRadius = 10
        ans5.layer.borderColor = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
        ans5.layer.borderWidth = 2
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = Bundle.main.url(forResource: "gameNow", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
        
        //判斷哪一關
        switch gameName {
        case "g1Easy":
            allIts = ["Apple","Coffee","Tea","Cake","Banana","Lemon","Cookies","Orange","Milk","Chicken","Candy","Cherry","Pizza","Fish","Ice cream","Soup","Rice","Egg","Cheese","Tomato"]
            
            naxtGameName = "Game1"
            myLevel = "Easy"
            break
        case "g1Medium":
            allIts = ["Mango","Sandwich","Juice","Steak","Pineapple","Kiwi","Hot dog","Toast","Pear","French fries","Corn","Noodle","Donut","Strawberry","Chocolate","Grape","Pea","Bread","Fried rice","Hamburger"]
            naxtGameName = "Game1"
            myLevel = "Medium"
            break
        case "g1Hard":
            allIts = ["Mushroom","Muffins","Watermelon","Starfruit","Coconut","Cucumber","Meat bun","Potato","Dumplings","Pumpkin","Sugar cane","Broccoli","Guava","Peach","Papaya","Onion","Carrot","Peanut","Green paper","Eggpalant"]
            naxtGameName = "Game1"
            myLevel = "Hard"
            break
        case "g2Easy":
            allIts = ["Pencil","Paper","Brush","Palette","Knife","Chopping block","Kettle","Cup","Mop","Bucket","Broom","Dustpan","Needle","Thread","Pillow","Duvet","Toothbrush","Toothpaste","Towel","Soap"]
            naxtGameName = "Game2"
            myLevel = "Easy"
            break
        case "g2Medium":
            allIts = ["Table lamp","Book","Computer","Mouse","Radio","Recode","Scouring pad","Dish soap","Chopsticks","Bowl","Spatula","Pot","Wrench","Screwdriver","Saws","Ax","Sprinklers","Water pipe","Television","Remote control","Jump rope","Dumbbell","Iron","Ironing board","Clothes","Washboard","Comb","Mirror","Detergent","Scrub brushes"]
            naxtGameName = "Game2"
            myLevel = "Medium"
            break
        case "g2Hard":
            allIts = ["Pencil","Paper","Brush","Palette","Knife","Chopping block","Kettle","Cup","Mop","Bucket","Broom","Dustpan","Needle","Thread","Pillow","Duvet","Toothbrush","Toothpaste","Towel","Soap","Table lamp","Book","Computer","Mouse","Radio","Recode","Scouring pad","Dish soap","Chopsticks","Bowl","Spatula","Pot","Wrench","Screwdriver","Saws","Ax","Sprinklers","Water pipe","Television","Remote control","Jump rope","Dumbbell","Iron","Ironing board","Clothes","Washboard","Comb","Mirror","Detergent","Scrub brushes"]
            naxtGameName = "Game2"
            myLevel = "Hard"
            break
        case "g3Easy":
            allIts = ["Eagle","Rabbit","Fox","Turkey","Bear","Gorilla","Horse","Giraffe","Monkey","Elephant","Frog","Owl","Squirrel","Lion","Hippo","Zebra","Snake","Coon","Wolf","Tiger"]
            naxtGameName = "Game3"
            myLevel = "Easy"
            break
        case "g3Medium":
            allIts = ["Sloth","Deer","Bat","Kangaroo","Ostrich","Peacock","Duck","Yak","Parrot","Goat","Rhinoceros","Crow","Koala","Turtle","Donkey","Goose","Crocodile","Panda","Wild boar","Leopard"]
            naxtGameName = "Game3"
            myLevel = "Medium"
            break
        case "g3Hard":
            allIts = ["Anteater","Platypus","Alpaca","Taiwan black bear","Vulture","Flamingo","Malayan tapir","Lizard","Leopard cat","Sugar glider","Pangolin","Meerket","Sparrow","Hedgehog","Chameleon","Groundhog","Skunk","Woodpecker","Heron","Penguin"]
            naxtGameName = "Game3"
            myLevel = "Hard"
            break
        default:
            break
        }
        //動畫1
        if mytimer == nil {
            mytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(calImageBoy), userInfo: nil, repeats: true)
            
            mytimer.fire()
        }else{
            mytimer.invalidate()
        }
        

        //
        
        //動畫2
        if mytimer2 == nil {
            mytimer2 = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(calImageHunter), userInfo: nil, repeats: true)
            
            mytimer2.fire()
        }else{
            mytimer2.invalidate()
        }
        

        //
        
        //計時器
        if mytimer3 == nil {
            mytimer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calTime), userInfo: nil, repeats: true)
            
            mytimer3.fire()
        } else {
            mytimer3.invalidate()
        }
        

        //第一題
        copyAllIts = allIts
        
        change()
        
        

        //飛行動畫
        flakeImage = UIImage(named: "Eagle2.png")
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector:
                #selector(self.onTimer), userInfo: nil, repeats: true)
            
            timer.fire()
        } else {
            timer.invalidate()
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    //換題目及選項
    func change() {
        //先清空選項
        fiveAns = []
        //1
        addIts = copyAllIts[Int(arc4random_uniform(UInt32(copyAllIts.count)))]
        //加入第一個
        fiveAns.append(addIts)
        //移除選擇到的
        if let indexNil=copyAllIts.index(of: addIts){
            copyAllIts.remove(at: indexNil)
        }
        
        //2
        addIts = copyAllIts[Int(arc4random_uniform(UInt32(copyAllIts.count)))]
        //加入第二個
        fiveAns.append(addIts)
        //移除選擇到的
        if let indexNil=copyAllIts.index(of: addIts){
            copyAllIts.remove(at: indexNil)
        }
        
        //3
        addIts = copyAllIts[Int(arc4random_uniform(UInt32(copyAllIts.count)))]
        //加入第三個
        fiveAns.append(addIts)
        //移除選擇到的
        if let indexNil=copyAllIts.index(of: addIts){
            copyAllIts.remove(at: indexNil)
        }
        
        //4
        addIts = copyAllIts[Int(arc4random_uniform(UInt32(copyAllIts.count)))]
        //加入第四個
        fiveAns.append(addIts)
        //移除選擇到的
        if let indexNil=copyAllIts.index(of: addIts){
            copyAllIts.remove(at: indexNil)
        }
        
        //5
        addIts = copyAllIts[Int(arc4random_uniform(UInt32(copyAllIts.count)))]
        //加入第五個
        fiveAns.append(addIts)
        //移除選擇到的
        if let indexNil=copyAllIts.index(of: addIts){
            copyAllIts.remove(at: indexNil)
        }
        
        //設定問題
        question = fiveAns[Int(arc4random_uniform(5))]
        //還原
        copyAllIts = allIts
        //扣除已出過之題目
        if let indexNil=copyAllIts.index(of: question){
            copyAllIts.remove(at: indexNil)
        }
        //扣除
        allIts = copyAllIts
        
        //畫面給予
        ans1.setBackgroundImage(UIImage(named: fiveAns[0]+"1"), for: .normal)
        ans2.setBackgroundImage(UIImage(named: fiveAns[1]+"1"), for: .normal)
        ans3.setBackgroundImage(UIImage(named: fiveAns[2]+"1"), for: .normal)
        ans4.setBackgroundImage(UIImage(named: fiveAns[3]+"1"), for: .normal)
        ans5.setBackgroundImage(UIImage(named: fiveAns[4]+"1"), for: .normal)
        
        questionLabel.text = question
    }
    
    //答對要做的所有事
    func correctA() {
        //1 爆炸動畫
        ans1.isEnabled = false
        ans2.isEnabled = false
        ans3.isEnabled = false
        ans4.isEnabled = false
        ans5.isEnabled = false
        
        boomImg.animationImages = (boomImgsLeft as! [UIImage])
        boomImg.animationDuration = 0.9
        boomImg.animationRepeatCount = 1
        boomImg.startAnimating()
        
        //2 扣血
        boyCount += 1
        if boyCount == 10 {
            boyCount = 9
            //延遲
            winOrNot = true
            perform(#selector(calWin), with: nil, afterDelay: 1)
        }
        boyBlood.image = boyBloodImgs[boyCount]
        

        
        //延遲
        perform(#selector(delayBtn1), with: nil, afterDelay: 0.9)
        
 
        
        //3 換題目以及選項

        change()
        
  
        
    }
    
    //答錯要做的所有事
    func errorA() {
        //1 爆炸動畫
        ans1.isEnabled = false
        ans2.isEnabled = false
        ans3.isEnabled = false
        ans4.isEnabled = false
        ans5.isEnabled = false
        
        boomImg.animationImages = (boomImgsRight as! [UIImage])
        boomImg.animationDuration = 0.9
        boomImg.animationRepeatCount = 1
        boomImg.startAnimating()
        
        //2 扣血
        hunterCount += 1
        if hunterCount == 10 {
            hunterCount = 9
            winOrNot = false
            //延遲
            perform(#selector(calWin), with: nil, afterDelay: 1)
        }
        hunterBlood.image = hunterBloodImgs[hunterCount]
        
        

        
        //延遲
        perform(#selector(delayBtn2), with: nil, afterDelay: 1)
        
    }
    
    @objc func calWin() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "win") as! WinViewController
        vc.myCount = boyCount
        vc.myTime = timeCount
        vc.reduceCount = hunterCount
        vc.winOrNot = winOrNot
        vc.gameName = naxtGameName
        vc.myLevel = myLevel
        present(vc, animated: true, completion: nil)
    }

    @IBAction func calAns1(_ sender: UIButton) {
        if fiveAns[0] == question{
            correctA()
        }else{
            errorA()
        }
    }
    @IBAction func calAns2(_ sender: UIButton) {
        if fiveAns[1] == question{
            correctA()
        }else{
            errorA()

        }
    }
    @IBAction func calAns3(_ sender: UIButton) {
        if fiveAns[2] == question{
            correctA()
        }else{
            errorA()

        }
    }
    @IBAction func calAns4(_ sender: UIButton) {
        if fiveAns[3] == question{
            correctA()
        }else{
            errorA()

        }
    }
    @IBAction func calAns5(_ sender: UIButton) {
        if fiveAns[4] == question{
            correctA()
        }else{
            errorA()

        }
    }
    @IBAction func calBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    var imageIndex=0
    
    @objc func calImageBoy() {
        
        boyImg.image=boyAry[imageIndex]
        imageIndex=imageIndex+1
        if imageIndex==3{
            imageIndex=0
        }
        
    }
    
    @objc func calImageHunter() {
        
        hunterImg.image=hunterAry[imageIndex]
        imageIndex=imageIndex+1
        if imageIndex==3{
            imageIndex=0
        }
        
    }
    
    @objc func delayBtn1() {
        ans1.isEnabled = true
        ans2.isEnabled = true
        ans3.isEnabled = true
        ans4.isEnabled = true
        ans5.isEnabled = true
        
        //4 叫聲
        let url2 = Bundle.main.url(forResource: "hunterOh", withExtension: "wav")
        do {
            hunterAudioPlayer = try AVAudioPlayer(contentsOf: url2!)
            hunterAudioPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        hunterAudioPlayer.play()
        //震動
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    @objc func delayBtn2() {
        ans1.isEnabled = true
        ans2.isEnabled = true
        ans3.isEnabled = true
        ans4.isEnabled = true
        ans5.isEnabled = true
        
        //4 叫聲
        let url3 = Bundle.main.url(forResource: "boyOh", withExtension: "wav")
        do {
            boyAudioPlayer = try AVAudioPlayer(contentsOf: url3!)
            boyAudioPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        
        boyAudioPlayer.play()
        //震動
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
     @objc func calTime() {
        timeCount += 1
        if timeCount > 600{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "win") as! WinViewController
            vc.myCount = boyCount
            vc.reduceCount = hunterCount
            vc.myTime = timeCount
            vc.winOrNot = false
            vc.gameName = naxtGameName
            vc.myLevel = myLevel
            present(vc, animated: true, completion: nil)
        }
        timeLabel.text = String(timeCount)
    }
    
    
    //
    @objc func onTimer() {
        
        
        
        let flakeImageView = UIImageView(image: flakeImage)
        let startX: Int = Int(arc4random()) % Int(UIScreen.main.bounds.maxX) // 0~670
        let endX: Int = Int(arc4random()) % Int(UIScreen.main.bounds.maxX)
        let scale: Float = Float( Int(arc4random()) % 100 ) / 100.0 + 0.5 // 0.5 ~ 1.5
       // let speed: Float = Float( Int(arc4random()) % 100 ) / 100.0 + 1.0 // 1.0 ~ 2.0
        let cgScale = CGFloat(scale) * 70.0
       // let cgSpeed = CGFloat(speed) * 35.0
        flakeImageView.frame = CGRect(x: CGFloat(startX), y: CGFloat(UIScreen.main.bounds.maxY), width: cgScale, height:cgScale)
        
        flakeImageView.alpha = 1
        self.view.addSubview(flakeImageView)
        
        
        
        UIView.animate(
            withDuration: 10, animations: {
                flakeImageView.frame=CGRect(x: CGFloat(endX), y: -100.0, width: cgScale, height:cgScale)
        }
            )
        {
            (value) in
            flakeImageView.removeFromSuperview()
        }
        
        
        
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
