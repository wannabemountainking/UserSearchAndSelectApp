//
//  ViewController.swift
//  UserSearchAndSelectApp
//
//  Created by YoonieMac on 7/22/25.
//

import UIKit

class FirstViewController: UIViewController {
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.text = "선택된 사용자 없음"
        label.textColor = .black
        label.backgroundColor = .secondarySystemBackground
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("사용자 검색하기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemTeal
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setAutoLayout()
    }
    
    func setup() {
        
    }
    
    func setAutoLayout() {
        
    }


}

