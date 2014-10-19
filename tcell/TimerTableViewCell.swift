//
//  TimerTableViewCell.swift
//  tcell
//
//  Created by Duczi on 17/10/14.
//  Copyright (c) 2014 Michal Duczynski. All rights reserved.
//


import UIKit

class TimerTableViewCell: UITableViewCell {
    
    //Properties
    
    weak var timerModel: UserTimerModel?
    
    @IBOutlet weak var timerDisplay: UILabel!
    
    @IBOutlet weak var changeStateBtn: UIButton!
    
    @IBAction func addTenMinutes(sender: UIButton) {
        addToTime(10*60)
    }
    
    func addToTime(seconds:Double) {
        timerModel!.lengthInSeconds += seconds
        timerModel!.secondsLeft += seconds
        canRunTimer()
    }
    
    
    @IBAction func changeState(sender: UIButton) {
        let running = !timerModel!.running
        timerModel!.running = running
        let image = running ? "pause.png" : "run.png"
        sender.setTitle(image, forState: UIControlState.Normal)
        //sender.setBackgroundImage(UIImage(named: image), forState: UIControlState.Normal)
        if running {
            timerModel!.leftSince = NSDate()
        } else {
            //update how much time is left
            timerModel!.secondsLeft -= NSDate().timeIntervalSinceDate(timerModel!.leftSince)
        }
    }
    
    func setup(timerModel: UserTimerModel) {
        //TODO: move to init
        self.timerModel = timerModel
        timerDisplay.text = "0"
        self.selectionStyle = UITableViewCellSelectionStyle.None
        canRunTimer()
    }
    
    func canRunTimer() -> Bool {
        let canRun = (timerModel!.lengthInSeconds > 0)
        changeStateBtn.enabled = canRun
        return canRun
    }
    
    
}