//
//  MenuViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/2.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class MenuViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
   
    @IBOutlet var myView: UIView!
    @IBOutlet var myView2: UIView!
    @IBOutlet var myView3: UIView!
    @IBOutlet weak var blurEffect: UIView!
    @IBOutlet weak var loadImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

  
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let url = Bundle.main.url(forResource: "homeM", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        audioPlayer.stop()
    }
    
   
    @IBAction func show1(_ sender: UIButton) {
        
        blurEffect.frame = view.frame
        view.addSubview(blurEffect)
        
        myView.center = view.center
        myView.layer.cornerRadius = 20
        view.addSubview(myView)
    }
    
    @IBAction func show2(_ sender: UIButton) {
        
        blurEffect.frame = view.frame
        view.addSubview(blurEffect)
        
        myView2.center = view.center
        myView2.layer.cornerRadius = 20
        view.addSubview(myView2)
    }
    
    @IBAction func close1(_ sender: UIButton) {
        blurEffect.removeFromSuperview()
        myView.removeFromSuperview()
    }
    
    @IBAction func close2(_ sender: UIButton) {
        blurEffect.removeFromSuperview()
        myView2.removeFromSuperview()
    }
    
    @IBAction func calS1(_ sender: UIButton) {
        
        imageIndex = 0
        resourceNames = "Story1"
        
        myView3.center = view.center
        view.addSubview(myView3)
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:
            #selector(calImage(sender:)), userInfo: self, repeats: true)
    }
    
    @IBAction func calS2(_ sender: UIButton) {
        
        imageIndex = 0
        resourceNames = "Story2"
        
        myView3.center = view.center
        view.addSubview(myView3)
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:
            #selector(calImage(sender:)), userInfo: self, repeats: true)
        
        
    }
    
    @IBAction func calS3(_ sender: UIButton) {
        
        imageIndex = 0
        resourceNames = "Story3"
        
        myView3.center = view.center
        view.addSubview(myView3)
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:
            #selector(calImage(sender:)), userInfo: self, repeats: true)
    }
    
    @IBAction func calG1(_ sender: UIButton) {
        
        myView3.center = view.center
        view.addSubview(myView3)
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:
            #selector(calImageG1(sender:)), userInfo: self, repeats: true)
        
    }
    
    @IBAction func calG2(_ sender: UIButton) {
        myView3.center = view.center
        view.addSubview(myView3)
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:
            #selector(calImageG2(sender:)), userInfo: self, repeats: true)
    }
    
    @IBAction func calG3(_ sender: UIButton) {
        myView3.center = view.center
        view.addSubview(myView3)
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector:
            #selector(calImageG3(sender:)), userInfo: self, repeats: true)
    }
    
    
    func playVideo(resource:String,type:String) {
        
        let filePath = Bundle.main.path(forResource: resource, ofType: type)
        let videoURL = URL(fileURLWithPath: filePath!)
        
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        
    }
    
    let myImages:[UIImage]=[
        UIImage(named:"l1")!,
        UIImage(named:"l2")!,
        UIImage(named:"l3")!,
        UIImage(named:"l4")!,
        UIImage(named:"l5")!,
        UIImage(named:"l6")!,
        UIImage(named:"l7")!,
        UIImage(named:"l8")!,
        UIImage(named:"l9")!,
        UIImage(named:"l10")!,
        UIImage(named:"l11")!,
        UIImage(named:"l12")!,
        UIImage(named:"l13")!,
        UIImage(named:"l14")!,
        UIImage(named:"l15")!,
        UIImage(named:"l16")!,
        UIImage(named:"l17")!,
        UIImage(named:"l18")!,
        UIImage(named:"l19")!,
        UIImage(named:"l20")!
        ]
    
    var imageIndex=0
    
    var resourceNames = ""
    
    @objc func calImage(sender:AnyObject) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            sender.invalidate()//把時間清空

            playVideo(resource: resourceNames, type: "mp4")
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
        
        
        
    }
    
    @objc func calImageG1(sender:AnyObject) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            sender.invalidate()//把時間清空
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "g1Menu") as! G1MenuViewController
            present(vc, animated: true, completion: nil)
            
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
    }
    
    @objc func calImageG2(sender:AnyObject) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            sender.invalidate()//把時間清空
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "g2Menu") as! G2MenuViewController
            present(vc, animated: true, completion: nil)
            
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
    }
    
    @objc func calImageG3(sender:AnyObject) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            sender.invalidate()//把時間清空
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "g3Menu") as! G3MenuViewController
            present(vc, animated: true, completion: nil)
            
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
    }
    
    @IBAction func calHelper(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "myTab") as! MyTabViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func calAbout(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as! WebViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func calWord(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "word") as! WordViewController
        present(vc, animated: true, completion: nil)
    }
    @IBAction func calRanking(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabScore") as! TabScoreViewController
        present(vc, animated: true, completion: nil)
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
