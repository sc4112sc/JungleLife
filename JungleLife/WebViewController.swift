//
//  WebViewController.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/1/8.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate {

    
    
    @IBOutlet weak var active: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

        guard let url = URL(string: "https://github.com/sc4112sc") else { return }
        let request = URLRequest(url: url)
        // 設定 WKWebView 的縮放屬性：在載入網頁之前，嘗試設定 WKWebView 的 scrollView 的 contentInsetAdjustmentBehavior 屬性為 .never，這可以避免頂部和底部的留白。
        webView.scrollView.contentInsetAdjustmentBehavior = .never

        webView.load(request)
        // Do any additional setup after loading the view.
    }


    @IBAction func calHome(_ sender: Any) {
        dismissCurrentPage()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        active.stopAnimating()
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
