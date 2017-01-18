//
//  TestCell.swift
//  StaticLib
//
//  Created by Roma Novakov on 17.01.17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import StaticLib

class TestCell: AbstractTableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        print("init(style: UITableViewCellStyle, reuseIdentifier: String?)")
        
        self.contentView.backgroundColor = UIColor.red
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}


class TestViewModel: AbstractViewModel {
    
    override init() {
        super.init()
        
        self.viewIdentifire = "cell_test"
        self.viewClassName = "TestCell"
    }
    
}
