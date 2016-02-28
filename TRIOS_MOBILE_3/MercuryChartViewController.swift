//
//  MercuryChartViewController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/27/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class MercuryChartViewController: UIViewController, MercuryInstrumentDelegate, MercuryHasInstrumentProtocol
{
   var _instrument:MercuryInstrument!
   var _signalsResponse: MercuryRealTimeSignalsStatusResponse!
   
   
   var instrument:MercuryInstrument
      {
      get{ return _instrument}
      set
      {
         _instrument = newValue
         _instrument.addDelegate(self)
      }
   }
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
   
   override func viewDidDisappear(animated: Bool)
   {
      _instrument.removeDelegate(self)
   }
   
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   // MARK: - MercuryInstrumentDelegate
   
   func stat(message: NSData!, withSubcommand subcommand: uint)
   {
      if(subcommand == RealTimeSignalStatus.rawValue)
      {
         print("REALTIMESIGNALS !!!!!!")
         
         _signalsResponse = MercuryRealTimeSignalsStatusResponse(message: message)
         
         dispatch_async(dispatch_get_main_queue(),
            { () -> Void in
         })
      }
   }
   
   func connected()
   {
   }
   
   func accept(access: MercuryAccess)
   {
   }
   
   func response(
      message: NSData!,
      withSequenceNumber sequenceNumber: uint,
      subcommand: uint,
      status: uint)
   {
   }
   
   func ackWithSequenceNumber(sequencenumber: uint)
   {
   }
   
   func nakWithSequenceNumber(sequencenumber: uint, andError errorcode: uint)
   {
   }
   
   /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
   
   
}
