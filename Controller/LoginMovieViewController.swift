//
//  LoginMovieViewController.swift
//  Swift5introApp2
//
//  Created by 玉城秀大 on 2020/12/13.
//

import UIKit
import AVFoundation  //動画などでよく使われる

class LoginMovieViewController: UIViewController {

    
    var player = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "start", ofType: "mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVプレイヤー用のlayerを生成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.repeatCount = 0 //動画の無限ループに繋がる
        playerLayer.zPosition = -1  //ログインボタンを上に持っていきたいから
        view.layer.insertSublayer(playerLayer, at: 0)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { (_) in
            self.player.seek(to: .zero)
            self.player.play()
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    
    
    @IBAction func login(_ sender: Any) {
        player.pause()  //動画を止める
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
