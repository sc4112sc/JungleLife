//
//  WebViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/8.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    var mytimer:Timer!
    
    @IBOutlet weak var active: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        if mytimer == nil {
            mytimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(calActive(sender:)), userInfo: nil, repeats: true)
            
            mytimer.fire()
        }else{
            mytimer.invalidate()
        }
        
        let url = URL(string: "https://www.facebook.com/KidDreamer5/")
        let request = URLRequest(url: url!)
        webView.load(request)
        // Do any additional setup after loading the view.
    }


    @IBAction func calHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var index=0
    
    @objc func calActive(sender:AnyObject) {
        
        
        index = index + 1
        if index == 3 {
            index = 0
            sender.invalidate()//把時間清空
            active.stopAnimating()
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
