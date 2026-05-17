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
import ChainableAnimations


class MenuViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    var loadingTimer: Timer?
    var hasAnimatedButtons = false
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var btn6: UIButton!
    
   
    @IBOutlet var myView: UIView!
    @IBOutlet var myView2: UIView!
    @IBOutlet var myView3: UIView!
    @IBOutlet var launchedOnceView: UIView!
    @IBOutlet weak var blurEffect: UIView!
    @IBOutlet weak var loadImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

  
        
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //nav
        self.launchedOnceView.frame = UIScreen.main.bounds
        
        
        
        imageViewA.image = UIImage(named: "nav1.jpg")
        tempImageView = imageViewB
        
        if pageControl.currentPage == 0 {
            leftBtn.isHidden = true
        }
        
        //偵測
        let alreadyLaunchedOnce = isAppAlreadyLaunchedOnce()
        
        if alreadyLaunchedOnce == false {
            
            
            launchedOnceView.center = view.center
            
            
            
            
            //ChainableAnimations
            let animator = ChainableAnimator(view: rightBtn)
            animator.transform(x: 50).bounce.thenAfter(t: 1.0).transform(x: -50).spring.animate(t: 1.0)
            
            let okAnimator = ChainableAnimator(view: okBtn)
            okAnimator.transform(scale: 0.5).bounce.thenAfter(t: 1.0).transform(scale: 2.0).bounce.animate(t: 1.0)
            
            view.addSubview(launchedOnceView)
            
            
        }
        

        
        self.myView3.frame = UIScreen.main.bounds
        
        guard let url = Bundle.main.url(forResource: "homeM", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error:", error.localizedDescription)
        }
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
        
        
        //按鈕動畫
        if !hasAnimatedButtons {
            animateMenuButtons()
            hasAnimatedButtons = true
        }
        

        
        //
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loadingTimer?.invalidate()
        loadingTimer = nil
        audioPlayer?.stop()
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
        startLoadingTransition(selector: #selector(calImage(_:)))
    }
    
    @IBAction func calS2(_ sender: UIButton) {
        imageIndex = 0
        resourceNames = "Story2"
        startLoadingTransition(selector: #selector(calImage(_:)))
    }
    
    @IBAction func calS3(_ sender: UIButton) {
        imageIndex = 0
        resourceNames = "Story3"
        startLoadingTransition(selector: #selector(calImage(_:)))
    }
    
    @IBAction func calG1(_ sender: UIButton) {
        startLoadingTransition(selector: #selector(calImageG1(_:)))
    }
    
    @IBAction func calG2(_ sender: UIButton) {
        startLoadingTransition(selector: #selector(calImageG2(_:)))
    }
    
    @IBAction func calG3(_ sender: UIButton) {
        startLoadingTransition(selector: #selector(calImageG3(_:)))
    }
    
    
    func playVideo(resource:String,type:String) {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
        }
        
        let filePath = Bundle.main.path(forResource: resource, ofType: type)
        let videoURL = URL(fileURLWithPath: filePath!)
        
        let player = AVPlayer(url: videoURL)
        //強制橫向
        let playerViewController = LandscapeAVPlayerController()
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
    
    var imageIndex = 0
    
    var resourceNames = ""
    
    @objc func calImage(_ timer: Timer) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            finishLoadingTransition(timer)

            playVideo(resource: resourceNames, type: "mp4")
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
        
        
        
    }
    
    @objc func calImageG1(_ timer: Timer) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            finishLoadingTransition(timer)
            
            //音樂暫停
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "g1Menu") as? G1MenuViewController else { return }
            present(vc, animated: true, completion: nil)
            
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
    }
    
    @objc func calImageG2(_ timer: Timer) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            finishLoadingTransition(timer)
            
            //音樂暫停
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "g2Menu") as? G2MenuViewController else { return }
            present(vc, animated: true, completion: nil)
            
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
    }
    
    @objc func calImageG3(_ timer: Timer) {
        
        loadImage.image = myImages[imageIndex]
        imageIndex = imageIndex + 1
        if imageIndex == 20 {
            imageIndex = 0
            finishLoadingTransition(timer)
            
            //音樂暫停
            if audioPlayer?.isPlaying == true {
                audioPlayer?.stop()
            }
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "g3Menu") as? G3MenuViewController else { return }
            present(vc, animated: true, completion: nil)
            
            myView3.removeFromSuperview()
            loadImage.image = UIImage(named:"l1")
        }
        
    }
    
    @IBAction func calHelper(_ sender: UIButton) {
        guard presentedViewController == nil else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "myTab") as? MyTabViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func calAbout(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "web") as! WebViewController
//        present(vc, animated: true, completion: nil)
        
        launchedOnceView.center = view.center
        pageControl.currentPage = 0
        imageViewA.image = UIImage(named: "nav1.jpg")
        imageViewB.image = UIImage(named: "nav1.jpg")
        if pageControl.currentPage == 0 {
            leftBtn.isHidden = true
        }
        rightBtn.isHidden = false
        
        
      
        //ChainableAnimations
        let animator = ChainableAnimator(view: rightBtn)
        animator.transform(x: 50).bounce.thenAfter(t: 1.0).transform(x: -50).spring.animate(t: 1.0)
        
        let okAnimator = ChainableAnimator(view: okBtn)
        okAnimator.transform(scale: 0.5).bounce.thenAfter(t: 1.0).transform(scale: 2.0).bounce.animate(t: 1.0)
        
        view.addSubview(launchedOnceView)
        
        
    }
    
    @IBAction func calWord(_ sender: UIButton) {
        guard presentedViewController == nil else { return }
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
        }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "word") as? WordViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    @IBAction func calRanking(_ sender: UIButton) {
        guard presentedViewController == nil else { return }
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabScore") as? TabScoreViewController else { return }
        present(vc, animated: true, completion: nil)
    }
    
    
    //查看是否為第一次開啟
    func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let isAppAlreadyLaunchedOnce = defaults.string(forKey: "isAppAlreadyLaunchedOnce") {
            print("App already lauched : \(isAppAlreadyLaunchedOnce)")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App lauched first time")
            return false
        }
    }
    
    
    var tempImageView: UIImageView!
    var bgImageView: UIImageView!
    @IBOutlet weak var imageViewA: UIImageView!
    @IBOutlet weak var imageViewB: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    
    @IBAction func closePage(_ sender: Any) {
        
        launchedOnceView.removeFromSuperview()
    }
    
    
    @IBAction func nextPage(_ sender: Any) {
        
        
        
        if pageControl.currentPage < 7 {
            pageControl.currentPage = pageControl.currentPage + 1
            pageTurning()
            leftBtn.isHidden = false

        }
        
        if pageControl.currentPage == 7{
            rightBtn.isHidden = true
        }
       
        
        
        //ChainableAnimations
        let animator = ChainableAnimator(view: leftBtn)
        animator.transform(x: -50).bounce.thenAfter(t: 1.0).transform(x: 50).spring.animate(t: 1.0)
        
        //ChainableAnimations
        let animator2 = ChainableAnimator(view: rightBtn)
        animator2.transform(x: 50).bounce.thenAfter(t: 1.0).transform(x: -50).spring.animate(t: 1.0)
        
        let okAnimator = ChainableAnimator(view: okBtn)
        okAnimator.transform(scale: 0.5).bounce.thenAfter(t: 1.0).transform(scale: 2.0).bounce.animate(t: 1.0)
        
    }
    
    @IBAction func returnPage(_ sender: Any) {
        
       
        if pageControl.currentPage > 0 {
            pageControl.currentPage = pageControl.currentPage - 1
            pageTurning()
            rightBtn.isHidden = false
            
            
        }
        
        if pageControl.currentPage == 0{
            leftBtn.isHidden = true
        }
        
        //ChainableAnimations
        let animator = ChainableAnimator(view: leftBtn)
        animator.transform(x: -50).bounce.thenAfter(t: 1.0).transform(x: 50).spring.animate(t: 1.0)
        
        //ChainableAnimations
        let animator2 = ChainableAnimator(view: rightBtn)
        animator2.transform(x: 50).bounce.thenAfter(t: 1.0).transform(x: -50).spring.animate(t: 1.0)
        
        let okAnimator = ChainableAnimator(view: okBtn)
        okAnimator.transform(scale: 0.5).bounce.thenAfter(t: 1.0).transform(scale: 2.0).bounce.animate(t: 1.0)
        
    }
    
    //nav
    func pageTurning() {
        
        let picNumber = "nav" + String(pageControl.currentPage + 1) + ".jpg"
        tempImageView.image = UIImage(named: picNumber)
        
        if tempImageView.tag == 0 {
            tempImageView = imageViewB;
            bgImageView = imageViewA;
        } else {
            tempImageView = imageViewA;
            bgImageView = imageViewB;
        }
        
        
        
        UIView.beginAnimations("fipping View", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationTransition(UIView.AnimationTransition.curlUp, for: tempImageView, cache: true)
        tempImageView.isHidden = true
        // 將 pageControll 元件放在最前
        view.bringSubviewToFront(pageControl)
        view.bringSubviewToFront(leftBtn)
        view.bringSubviewToFront(rightBtn)
        
        UIView.commitAnimations()
        
        UIView.beginAnimations("fipping View", context: nil)
        UIView.setAnimationDuration(0.5)
        UIView.setAnimationCurve(UIView.AnimationCurve.easeInOut)
        UIView.setAnimationTransition(UIView.AnimationTransition.curlDown, for: bgImageView, cache: true)
        bgImageView.isHidden = false
        view.bringSubviewToFront(pageControl)
        view.bringSubviewToFront(leftBtn)
        view.bringSubviewToFront(rightBtn)

       
        UIView.commitAnimations()
    }
    
    private func animateMenuButtons() {
        let buttons = [btn1, btn2, btn3, btn4, btn5, btn6].compactMap { $0 }
        for (index, button) in buttons.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (Double(index) * 0.18)) {
                let animator = ChainableAnimator(view: button)
                animator.make(backgroundColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)).thenAfter(t: 0.4).make(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)).animate(t: 0.45)
            }
        }
    }
    
    private func startLoadingTransition(selector: Selector) {
        guard loadingTimer == nil else { return }
        myView3.center = view.center
        view.addSubview(myView3)
        loadingTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: selector, userInfo: nil, repeats: true)
    }
    
    private func finishLoadingTransition(_ timer: Timer) {
        timer.invalidate()
        loadingTimer = nil
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
