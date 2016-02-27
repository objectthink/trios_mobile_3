//
//  InstrumentTabBarController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/27/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class InstrumentTabBarController: UITabBarController
{
   var _instrument:MercuryInstrument!
   var instrument:MercuryInstrument!
   {
      get{ return _instrument}
      set
      {
         _instrument = newValue
         
         // Do any additional setup after loading the view.
         for vc in viewControllers!
         {
            if let msvc:MecurySignalsViewController = vc as? MecurySignalsViewController
            {
               msvc.instrument = instrument
            }
         }

      }
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
   }
   
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
//   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
//   {
//      // Get the new view controller using segue.destinationViewController.
//      // Pass the selected object to the new view controller.
//      
//      _ = segue.destinationViewController
//   }
   
}
