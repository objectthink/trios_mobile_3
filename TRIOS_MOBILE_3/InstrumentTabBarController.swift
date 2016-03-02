//
//  InstrumentTabBarController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/27/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class InstrumentTabBarController: UITabBarController, MercuryInstrumentDelegate
{
   var _instrumentName:String! = "Name"
   var _status:String! = "Status"
   
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
            if let vc:MercuryHasInstrumentProtocol = vc as? MercuryHasInstrumentProtocol
            {
               vc.instrument = instrument
            }
         }
         
         _instrument.sendCommand(GetName())
         { (response) -> Void in
            if let str = NSString(data: response.bytes, encoding: NSUTF8StringEncoding) as? String
            {
               self._instrumentName = self.mercuryStringFixup(str)
               
               dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                     
                     self.title = self._instrumentName + " : " + self._status
               })
            }
         }
         
         _instrument.sendCommand(MercuryGetProcedureStatusCommand())
         { (r) -> Void in
               let response = MercuryProcedureStatusResponse(message: NSData(data: r.bytes))
               
               let runStatus = response.runStatus.rawValue
               
               switch(runStatus)
               {
               case  0:
                  self._status = "Idle"
               case 1:
                  self._status = "PreTest"
               case 2:
                  self._status = "Test"
               case 3:
                  self._status = "PostTest"
               default:
                  self._status = "AAAAAA"
               }
               
               dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                     
                     self.title = self._instrumentName + " : " + self._status
               })
               
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
   
   func mercuryStringFixup(s:String)->String
   {
      var sOut:String = String()
      
      for character in s.characters
      {
         if character != "\0"
         {
            sOut.append(character)
         }
      }
      
      return sOut
   }
   
   // MARK: - MercuryInstrumentDelegate
   
   func stat(message: NSData!, withSubcommand subcommand: uint)
   {
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
