//
//  ViewController.swift
//  CutyTimePicker
//
//  Created by TakanoriMatsumoto on 2015/02/03.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let calendarVC = CalendarViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addChildViewController(calendarVC)
        view.addSubview(calendarVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendarVC.view.frame = view.bounds
    }


}

