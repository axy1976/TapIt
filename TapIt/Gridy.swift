//
//  Gridy.swift
//  TapIt
//
//  Created by Akshay Jangir on 05/07/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class Gridy: UICollectionViewCell {
    func setupCell(with status:Int,_ i:Int) {
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.black.cgColor
        if(status == i) {
            contentView.backgroundColor = .none
        }
        else
        {
            contentView.backgroundColor = .blue
        }
    }
}
