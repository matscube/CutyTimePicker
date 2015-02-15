//
//  DayCell.swift
//  CutyTimePicker
//
//  Created by TakanoriMatsumoto on 2015/02/10.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    let dateLabel = UILabel()
    func setDateComp(dateComp: NSDateComponents) {
        let day = dateComp.day
    }
}
