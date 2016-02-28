//
//  RunningMethodViewController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/28/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class RunningMethodViewController: UIViewController, MercuryHasInstrumentProtocol
{
   var _instrument:MercuryInstrument!
   
   var instrument:MercuryInstrument
   {
      get { return _instrument }
      set
      {
         _instrument = newValue
      }
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
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
      
      if let vc:MercuryHasInstrumentProtocol = segue.destinationViewController as? MercuryHasInstrumentProtocol
      {
         vc.instrument = instrument
      }
   }

}
