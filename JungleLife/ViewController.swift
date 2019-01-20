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

    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var progress: UIProgressView!
    
    @IBOutlet var myView: UIView!
    var count:Float=0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        progress.progress = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url = Bundle.main.url(forResource: "mainM", withExtension: "mp3")
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

    @IBAction func calMenu(_ sender: UIButton) {

        myView.center = view.center
        view.addSubview(myView)
        
        count = 0
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:
            #selector(onTimer(sender:)), userInfo: self, repeats: true)
    }
    @IBAction func calAbout(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as! WebViewController
        present(vc, animated: true, completion: nil)
    }
    
    @objc func onTimer(sender:AnyObject){
        count = count + 0.1;
        progress.progress = count
        
        
        if progress.progress >= 1.0 {
            progress.progress = 0.0

            sender.invalidate()//把時間清空
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "menu") as! MenuViewController
            
            present(vc, animated: true, completion: nil)
            
        }
        
    }

    
}
