//
//  CalendarViewController.swift
//  CutyTimePicker
//
//  Created by TakanoriMatsumoto on 2015/02/06.
//  Copyright (c) 2015年 TakanoriMatsumoto. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let timeManager = TimeManager()
    private var calendar: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        calendar = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        calendar.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: LabelCellReuseIdentifier)
        calendar.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: DayCellReuseIdentifier)
        calendar.delegate = self
        calendar.dataSource = self
        view.addSubview(calendar)
        
        view.backgroundColor = UIColor.blueColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loadDaySet()
        calendar.reloadData()
    }
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calendar.frame = view.bounds
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(50, 50)
    }
//    optional func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
//    optional func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
//    optional func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat

    // MARK: - Datasource
    var daySet = [NSDate]()
    func loadDaySet() {
        let year: Int = 2015
        let month: Int = 2
        daySet = timeManager.getCalendarMonthDaySet(year, month: month)
    }
    let LabelCellReuseIdentifier: String = "LabelCellReuseIdentifier"
    let DayCellReuseIdentifier: String = "DayCellReuseIdentifier"
    enum Section : Int {
        case Label = 0
        case Day
        static var size = 2
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Section.size
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch (section) {
        case Section.Label.toRaw(): return 7
        case Section.Day.toRaw(): return daySet.count
        default:
            // Error
            return 0
        }
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        var cell: UICollectionViewCell!
        switch (section) {
        case Section.Label.toRaw():
            cell = labelCell(collectionView, cellForItemAtIndexPath: indexPath)
        case Section.Day.toRaw():
            cell = dayCell(collectionView, cellForItemAtIndexPath: indexPath)
        default:
            // Error
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(LabelCellReuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        }
        
        // test
        cell.backgroundColor = UIColor.redColor()

        return cell
    }
    private func labelCell(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        let virtualDate = daySet[row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LabelCellReuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EE"
        let weekDayName = dateFormatter.stringFromDate(virtualDate)
        let label = UILabel()
        label.frame = cell.contentView.bounds
        label.text = "\(weekDayName)"
        cell.contentView.addSubview(label)

        return cell
    }
    private func dayCell(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(DayCellReuseIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        let row = indexPath.row
        
        let date = daySet[row]
        let dateComp = timeManager.getDateComponents(date)
        let label = UILabel()
        label.frame = cell.contentView.bounds
        label.text = "\(dateComp.day)"
        label.textColor = UIColor.blueColor()
        cell.contentView.addSubview(label)
        
        return cell
    }
    

}
