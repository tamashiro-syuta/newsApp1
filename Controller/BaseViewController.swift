//
//  BaseViewController.swift
//  Swift5introApp2
//
//  Created by 玉城秀大 on 2020/12/13.
//

import UIKit
import SegementSlide  //タブのついた遷移が可能になる(ex:スマートニュース)

class BaseViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        reloadData()
        defaultSelectedIndex = 0
        
    }
    
    override func segementSlideHeaderView() -> UIView? {
        let headerView = UIImageView()
        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleAspectFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let headerHeight:CGFloat
        if #available(iOS 11.0, *) {
            headerHeight = view.bounds.height / 4 + view.safeAreaInsets.top
        }else {
            headerHeight = view.bounds.height / 4 + topLayoutGuide.length
        }
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        return headerView
    }
    
    override var titlesInSwitcher:[String] {
        return ["TOP","エンタメ","沖縄","IT","バスケ","CNN"]
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        switch index {
        case 0:
            return Page1ViewController()
        case 1:
            return Page2ViewController()
        case 2:
            return Page3ViewController()
        case 3:
            return Page4ViewController()
        case 4:
            return Page5ViewController()
        case 5:
            return Page6ViewController()
            
        default:
            return Page1ViewController()
        }
    }

    
}
