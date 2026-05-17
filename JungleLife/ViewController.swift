//
//  ViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/1.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

  
   
    
    
    var mytimer: Timer?
    var menuTransitionTimer: Timer?
    weak var menuButton: UIButton?
    
    var cloudAry = [UIImage(named: "nilBg1"),UIImage(named: "cloud"),UIImage(named: "cloud2"),UIImage(named: "cloud3"),UIImage(named: "cloud4"),UIImage(named: "cloud5"),UIImage(named: "cloud6"),UIImage(named: "cloud7"),UIImage(named: "cloud8"),UIImage(named: "cloud9"),UIImage(named: "cloud10"),UIImage(named: "cloud11"),UIImage(named: "cloud12"),UIImage(named: "cloud13")]
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var cloudImg: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet var myView: UIView!
    
    var count:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.myView.frame = UIScreen.main.bounds

        
        startCloudAnimation()
        
        progress.progress = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let url = Bundle.main.url(forResource: "mainM", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        menuTransitionTimer?.invalidate()
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
        }
    }
    
    deinit {
        mytimer?.invalidate()
        menuTransitionTimer?.invalidate()
    }


    @IBAction func calMenu(_ sender: UIButton) {
        guard menuTransitionTimer == nil else { return }
        menuButton = sender

        myView.center = view.center
        view.addSubview(myView)
        
        count = 0
        progress.progress = 0
        sender.isEnabled = false
        
        menuTransitionTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:
            #selector(onTimer(_:)), userInfo: nil, repeats: true)
    }
    @IBAction func calAbout(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as? WebViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @objc func onTimer(_ timer: Timer) {
        count = count + 0.14;
        progress.progress = count
        
        
        if progress.progress >= 1.0 {
            progress.progress = 0.0

            timer.invalidate()
            menuTransitionTimer = nil
            

            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            
            menuButton?.isEnabled = true
            menuButton = nil
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as? MenuViewController else { return }
            
            present(vc, animated: true, completion: nil)
            
        }
        
    }

    var imageIndex=0
    
    @objc func calImageCloud() {
        
        cloudImg.image = cloudAry[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 14 {
            imageIndex = 0
        }
        
    }
    
    private func startCloudAnimation() {
        mytimer?.invalidate()
        imageIndex = 0
        mytimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(calImageCloud), userInfo: nil, repeats: true)
        mytimer?.fire()
    }
}
