//
//  ViewController.swift
//  SimpleCalendar
//
//  Created by RujuRaj on 3/3/16.
//  Copyright © 2016 RujuRaj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var daysStack2: UIStackView!

    @IBOutlet weak var daysStack5: UIStackView!
    @IBOutlet weak var daysStack4: UIStackView!
    @IBOutlet weak var daysStack3: UIStackView!
    @IBOutlet weak var daysStack1: UIStackView!
    @IBOutlet weak var daysStack0: UIStackView!
    @IBOutlet weak var weekStack: UIStackView!
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var mainStack: UIStackView!
    var brain=CalendarManagement()
    var savedEventId : String = ""
    var weekLetters=["M","T","W","T","F","S","S"]
    var stackDays=Array<UIStackView>()
    var btnDays=Array<UIButton>()
    var eventArr=Array<String>()
    var month:Int=0,year:Int=0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUIStacks()
        fillDataOfWeekStack()
        fillDataOfDaysStack()
        fillWithActualDates()
        setupSwipe()
    }
    func setupSwipe()
    {
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        leftSwipe.direction = .Left
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        rightSwipe.direction = .Right
        mainStack.addGestureRecognizer(leftSwipe)
        mainStack.addGestureRecognizer(rightSwipe)
        
    }
    func handleSwipe(sender:UISwipeGestureRecognizer)
    {
        
        if(sender.direction == .Right)
        {
            print("right")
            if (month <= 1)
            {
                month = 12;
                year -= 1;
            }
            else
            {
                month -= 1;
            }
            
        }
        else if(sender.direction == .Left)
        {
            print("left")
            if (month > 11)
            {
                month = 1;
                year += 1;
            }
            else
            {
                month += 1;
            }
        }
        brain.setup(month,yearVal: year)
        brain.setupButtons(btnDays)
        self.mainLabel.text="\(DateHelper.getMonthText(month)) \(year)"
    }
   
    func setupUIStacks()
    {
        stackDays.append(daysStack0)
        stackDays.append(daysStack1)
        stackDays.append(daysStack2)
        stackDays.append(daysStack3)
        stackDays.append(daysStack4)
        stackDays.append(daysStack5)
    }
    func fillDataOfWeekStack()
    {
        for weekday in weekLetters
        {
            let btn = UIButton(type: .System)
            btn.setTitle(weekday, forState: .Normal)
            weekStack.addArrangedSubview(btn)
        }
    }
    func fillDataOfDaysStack()
    {
        var j=1
        for i in 1...stackDays.count
        {
            for _ in weekLetters
            {
                let btn = UIButton(type: .System)
                btn.setTitle("\(j)", forState: .Normal)
                stackDays[i-1].addArrangedSubview(btn)
                
                btn.backgroundColor=UIColor(red: 236/255,green: 236/255,blue: 236/255,alpha: 0.8)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.addTarget(self, action: "dayClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                btnDays.append(btn)
                j += 1
            }
            
        }
        
    }
    func fillWithActualDates()
    {
        brain.setup(-1,yearVal: -1)
        brain.setupButtons(btnDays)
        month = DateHelper.getThisMonth() // based on index 1
        year = DateHelper.getThisYear()
        self.mainLabel.text="\(DateHelper.getMonthText(month)) \(year)"
    }
    func dayClicked(sender:UIButton!)
    {
        // click event
        print(sender.currentTitle!+"-\(month)-\(year)")
    }

}

