//
//  MecurySignalsViewController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/21/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class MecurySignalsViewController: UIViewController, MercuryHasInstrumentProtocol
{
   @IBOutlet var _signalsView: UIView!
   @IBOutlet var _chartView: UIView!
   
   var _instrument:MercuryInstrument!
   
   var instrument:MercuryInstrument
   {
      get { return _instrument }
      set
      {
         _instrument = newValue
      }
   }
   
   @IBAction func segmentSelectionChanged(sender: AnyObject)
   {
      if sender.selectedSegmentIndex == 0
      {
         UIView.animateWithDuration(0.5, animations:
         {
            self._signalsView.alpha = 1
            self._chartView.alpha = 0
         })
      }
      else
      {
         UIView.animateWithDuration(0.5, animations:
         {
            self._signalsView.alpha = 0
            self._chartView.alpha = 1
         })
      }
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      _chartView.alpha = 0
      
      // Do any additional setup after loading the view.
   }
   
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) 
   {
      // Get the new view controller using segue.destinationViewController.
      // Pass the selected object to the new view controller.
      
      if let vc:SignalsTableViewController = segue.destinationViewController as? SignalsTableViewController
      {
         vc.instrument = instrument
      }
   }
}
