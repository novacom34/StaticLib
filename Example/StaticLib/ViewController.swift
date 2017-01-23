//
//  ViewController.swift
//  StaticLib
//
//  Created by Roma Novakov on 05/09/2016.
//  Copyright (c) 2016 Roma Novakov. All rights reserved.
//

import UIKit
import StaticLib

class ViewController: AbstractTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modelArray = AbstractArrayModel()
        
        for _ in 0...20 {
            let vm = TestViewModel()
            self.modelArray?.addModel(vm)
        }
        
        
    }
}

