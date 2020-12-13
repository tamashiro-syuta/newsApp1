//
//  IntroViewController.swift
//  Swift5introApp2
//
//  Created by 玉城秀大 on 2020/12/13.
//

import UIKit
import Lottie

class IntroViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var onboardArray = ["1","2","3","4","5"]
    var onboardStringArray = ["あいうえお","かきくけこ","さしすせそ","たちつてと","なにぬねの"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.isPagingEnabled = true  //ページングできるようになる
        setUpScroll()
        
        for i in 0...4 {
            let animationView = AnimationView()
            let animation = Animation.named(onboardArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)  //アニメーションビューのサイズを決める
            animationView.animation = animation  //アニメーションビューのアニメーションに上で定義した定数animationを設定
            animationView.contentMode = .scaleAspectFit  //アニメーションのサイズ感
            animationView.loopMode = .loop  //アニメーションをループさせる
            animationView.play()  //アニメーションをプレイ
            scrollView.addSubview(animationView)  //スクロールビューにアニメーションビューを貼り付ける
        }
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        //ナビゲーションバーを消去
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    //スクロール画面を作成
    func setUpScroll() {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: scrollView.frame.size.height)
        
        for i in 0...4 {
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height / 3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
            scrollView.addSubview(onboardLabel)
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
