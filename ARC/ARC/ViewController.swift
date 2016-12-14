//
//  ViewController.swift
//  ARC
//
//  Created by Enrico Piovesan on 12/12/2016.
//  Copyright © 2016 none. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /* Step 1
     var reference1: Vehicle = Vehicle(kind: "CloudCar")
     var reference2: Vehicle?
     */
    /* step 2
    var reference1: Vehicle?
    var reference2: Vehicle?
    var reference3: Vehicle?
    
    var timer: Timer?
    var count = 0
     */
    
    var seatrooper : Stormtrooper?
    var submarine : Vehicle?
    var toogle = false
    let runButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         /* step 2
        reference1 = Vehicle(type: "CloudCar")
        reference2 = reference1
        reference3 = reference1
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.step), userInfo: nil, repeats: true)
        */
        
        /* step 3 */
        
        submarine = Vehicle(type: "Aquatic")
        seatrooper = Stormtrooper(specialization: "Aquatic")
        
        submarine!.stormtrooper = seatrooper
        seatrooper!.vehicle = submarine
        
        seatrooper = nil
        submarine = nil
        
        // Create run button
        runButton.frame = CGRect(x: 30, y: 30, width: 150, height: 30)
        runButton.setTitle("Run", for: UIControlState.normal)
        runButton.backgroundColor = UIColor.blue
        runButton.addTarget(self, action: #selector(self.toggleButtonTapped), for: UIControlEvents.touchUpInside)
        self.view.addSubview(runButton)
        
    }
    
    /* step 3 */
    func toggleButtonTapped(sender: UIButton) {
        if !toogle {
            
            runButton.setTitle("Stop", for: UIControlState.normal)
            runButton.backgroundColor = UIColor.red
            
            submarine = Vehicle(type: "Aquatic")
            seatrooper = Stormtrooper(specialization: "Aquatic")
            
            submarine!.stormtrooper = seatrooper
            seatrooper!.vehicle = submarine
            
            
        } else {
            
            runButton.setTitle("Run", for: UIControlState.normal)
            runButton.backgroundColor = UIColor.blue
            
            seatrooper = nil
            submarine = nil
            
        }
        
        toogle = !toogle
        
    }
    
    /* step 2
    func step() {
        
        if count >= 3 {
            reference3 = nil
            reference2 = nil
            print("the reference remains!")
        }
        
        if count >= 5 {
            reference1 = nil
            print("our object is deallocated!")
        }
        
        count = count + 1
        print("\(count) Step")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    */
    
    
}

