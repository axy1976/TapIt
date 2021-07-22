//
//  Leaderboard.swift
//  TapIt
//
//  Created by Akshay Jangir on 22/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class Leaderboard: UIViewController {
    
    let name = UserDefaults.standard.string(forKey: "name")
    let score = UserDefaults.standard.string(forKey: "score")
    
    private var lbln: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    private var btnx: UIButton = {
        let btn = UIButton()
        btn.setTitle("<- Back To Game", for: .normal)
        btn.backgroundColor = .none
        btn.setTitleColor(.blue, for: .normal)
        btn.addTarget(self, action: #selector(backToGame), for: .touchUpInside)
        return btn
    }()
    
    @objc private func backToGame() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground("andrej")
        view.addSubview(lbln)
        view.addSubview(btnx)
        lbln.text = "\(name!) \t | \t \(score!)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnx.frame = CGRect(x: 20, y: 20, width: 160, height: 40)
        lbln.frame = CGRect(x: 100, y: 100, width: view.width-200, height: 40)
    }
}
