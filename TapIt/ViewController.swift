//
//  ViewController.swift
//  TapIt
//
//  Created by Akshay Jangir on 05/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var temp = -1
    private var timerTest : Timer?
    private var timer : Int?
    private var cnttimer : Int = 0
    private var onoff = 0
    private var score = 0
    private var state = [0,1,2,
                         3,4,5,
                         6,7,8]
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 118, height: 118)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .none
        return collectionView
    }()
    private let blur: UIView = {
        let vu = UIView()
        return vu
    }()
    private let lbls: UILabel = {
        let lbl = UILabel()
        lbl.text = "SCORE : 0"
        lbl.textAlignment = .center
        lbl.isHidden = true
        return lbl
    }()
    private let btns: UIButton = {
        let btn = UIButton()
        btn.setTitle("S T A R T", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemGreen
        btn.layer.borderWidth = 3
        btn.layer.borderColor = UIColor.black.cgColor
        btn.addTarget(self, action: #selector(gameonoff), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        return btn
    }()
    @objc private func gameonoff() {
        if onoff == 0 {
            resetState()
            btns.setTitle("S T O P", for: .normal)
            btns.backgroundColor = .systemRed
            onoff = 1
            lbls.isHidden = false
            timerTest = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cellupdate), userInfo: nil, repeats: true)
        } else {
            btns.setTitle("S T A R T", for: .normal)
            btns.backgroundColor = .systemGreen
            onoff = 0
            lbls.isHidden = true
            timerTest?.invalidate()
            announceWinner()
        }
    }
    @objc private func cellupdate() {
        cnttimer = cnttimer + 1
        if cnttimer == timer {
            gameonoff()
            return
        }
        let r = Int.random(in: 0..<9)
        if temp != -1 {
            state[temp] = temp
        }
        temp = r
        state[r] = -1
        myCollectionView.reloadItems(at: [[0]])
        print(Double(cnttimer) * 0.5," + ",r)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground("andrej")
        view.addSubview(blur)
        blur.backgroundColor = .init(red: 1, green: 1, blue: 1, alpha: 0.4)
        view.addSubview(myCollectionView)
        setupCollectionView()
        view.addSubview(lbls)
        view.addSubview(btns)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blur.frame = view.bounds
        myCollectionView.frame = CGRect.init(x: 0, y: 0, width: view.width, height: 440)
        lbls.frame = CGRect.init(x: 50, y: 450, width: view.width-100, height: 20)
        btns.frame = CGRect.init(x: 50, y: 500, width: view.width-100, height: 70)
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    private func setupCollectionView() {
        myCollectionView.register(Gridy.self, forCellWithReuseIdentifier: "Gridy")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Gridy", for: indexPath) as! Gridy
        cell.setupCell(with: state[indexPath.row], indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if state[indexPath.row] != indexPath.row {
            score += 10
        } else {
            score -= 5
        }
        self.lbls.text = "SCORE : \(score)"
    }
    private func announceWinner() {
        let alert = UIAlertController(title: "Game over!", message: "[ Enter Player Name ]", preferredStyle: .alert)
        alert.addTextField { (tf) in
            tf.placeholder = "Player Name"
        }
        let action = UIAlertAction(title: "Submit", style: .default) { (_) in
            guard let name = alert.textFields?[0].text
                else{
                    self.announceWinner()
                    return
            }
            UserDefaults.standard.setValue(name, forKey: "name")
            UserDefaults.standard.setValue(self.score, forKey: "score")
            
            let vc = Leaderboard()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        alert.addAction(action)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    private func resetState() {
        temp = -1
        score = 0
        timer = 10
        cnttimer = 0
        state = [0,1,2,3,4,5,6,7,8]
        myCollectionView.reloadData()
    }
}
