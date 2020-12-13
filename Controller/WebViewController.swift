//
//  WebViewController.swift
//  Swift5introApp2
//
//  Created by 玉城秀大 on 2020/12/13.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {

    
    var webView = WKWebView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
        view.addSubview(webView)  //viewにwebViewを貼る
        
        let urlString = UserDefaults.standard.object(forKey: "url") //Page1ViewControllerで保存したフォーキーを定数化した
        let url = URL(string: urlString as! String) //Any型で保存したので何型かわからないからString型とし、それをURL型にキャスト
        let request = URLRequest(url: url!) //urlをURLRequest型に変換
        webView.load(request)
        
    }
    


}
