//
//  G3MenuViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/10.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import AVFoundation
class G3MenuViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var blurEffect: UIView!
    @IBOutlet var myView: UIView!
    @IBOutlet var myView2: UIView!
    @IBOutlet weak var g3Image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let url = Bundle.main.url(forResource: "game3M", withExtension: "mp3")
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
    
    @IBAction func calStart(_ sender: UIButton) {
        blurEffect.frame = view.frame
        view.addSubview(blurEffect)
        
        myView.center = view.center
        myView.layer.cornerRadius = 20
        view.addSubview(myView)
    }
    @IBAction func calClose(_ sender: UIButton) {
        blurEffect.removeFromSuperview()
        myView.removeFromSuperview()
    }
    @IBAction func calClose2(_ sender: UIButton) {
        blurEffect.removeFromSuperview()
        myView2.removeFromSuperview()
    }
    
    @IBAction func calInstruction(_ sender: UIButton) {
        blurEffect.frame = view.frame
        view.addSubview(blurEffect)
        
        myView2.center = view.center
        myView2.layer.cornerRadius = 20
        view.addSubview(myView2)
    }
    @IBAction func calEasy(_ sender: UIButton) {
        g3Image.image = UIImage(named: "g3_easy")
    }
    @IBAction func calMedium(_ sender: UIButton) {
        g3Image.image = UIImage(named: "g3_medium")
    }
    
    @IBAction func calHard(_ sender: Any) {
        g3Image.image = UIImage(named: "g3_hard")
    }
    @IBAction func calHome(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func goG1Easy(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "game1") as! Game1ViewController
        vc.gameName = "g3Easy"
        present(vc, animated: true, completion: nil)
    }
    @IBAction func goG1Medium(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "game1") as! Game1ViewController
        vc.gameName = "g3Medium"
        present(vc, animated: true, completion: nil)
    }
    @IBAction func goG1Hard(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "game1") as! Game1ViewController
        vc.gameName = "g3Hard"
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
