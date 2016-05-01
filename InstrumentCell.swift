//
//  InstrumentCell.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/20/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class GetSerialNumber:MercuryGet
{
   override init()
   {
      super.init()
      self.subCommandId = 0x00000002
   }
}

class GetName:MercuryGet
{
   override init()
   {
      super.init()
      self.subCommandId = 0x00000003
   }
}

class GetLocation:MercuryGet
{
   override init()
   {
      super.init()
      self.subCommandId = 0x00000004
   }
}

class InstrumentCell: UICollectionViewCell, MercuryInstrumentDelegate
{
    
   @IBOutlet var _instrumentName: UILabel!
   @IBOutlet var _statusLabel: UILabel!
   @IBOutlet var _name: UILabel!
   @IBOutlet var _serialNumber: UILabel!
   @IBOutlet var _location: UILabel!
   @IBOutlet var _temperature: UILabel!
   
   var _instrument:MercuryInstrument!
   var _isTrios:Bool!
   
   var isTrios:Bool
   {
      get{return _isTrios}
      set
      {
         _isTrios = newValue
      }
   }
   
   var instrument:MercuryInstrument!
   {
      get{ return _instrument}
      set
      {
         _instrument = newValue
         
         if _instrument.isTrios == true
         {
            self._name.text = "Trios"
            
            var client:TCPClient = TCPClient(addr: "10.52.53.26", port: 50007)
            var (success, errmsg) = client.connect(timeout: 10)
            if success
            {
               var (success, errmsg) = client.send(str:"InstrumentInformation" )
               if success
               {
                  var data = client.read(1024*10)
                  if let d = data
                  {
                     if let str = String(bytes: d, encoding: NSUTF8StringEncoding)
                     {
                        print(str)
                        
                        dispatch_async(dispatch_get_main_queue(),
                        { () -> Void in
                           let json = JSON(string: str)
                           let instrument = json!["Instrument"]
                           
                           let serialNumber = instrument!["SerialNumber"]?.string
                           let runState = instrument!["RunState"]?.string
                           let name = instrument!["Name"]?.string
                           
                           self._serialNumber.text = serialNumber
                           self._statusLabel.text = "Status: " + runState!
                           self._name.text = name

                        })
                     }
                  }
               }
               else
               {
                  print(errmsg)
               }
            }
            else
            {
               print(errmsg)
            }
            
            return
         }
         
         _instrument.addDelegate(self)
         
         _instrument.sendCommand(MercuryGetProcedureStatusCommand())
         { (r) -> Void in
         
            self._statusLabel.text = "Some status"
            
            let response = MercuryProcedureStatusResponse(message: NSData(data: r.bytes))
            
            print(response.endStatus)
            print(response.runStatus)
            print(response.currentSegmentId)
            
            let runStatus = response.runStatus.rawValue
            dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                  switch(runStatus)
                  {
                  case  0:
                     self._statusLabel.text = "Status: Idle"
                  case 1:
                     self._statusLabel.text = "Status: PreTest"
                  case 2:
                     self._statusLabel.text = "Status: Test"
                  case 3:
                     self._statusLabel.text = "Status: PostTest"
                  default:
                     self._statusLabel.text = "Status: Unknown"
                  }
                  
            })

            print(self._statusLabel.text)
         }
         
         _instrument.sendCommand(GetSerialNumber())
         {(response)-> Void in
            
            if let str = NSString(data: response.bytes, encoding: NSUTF8StringEncoding) as? String
            {
               print(str)
               
               dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                  self._serialNumber.text = str
                  print("SERIAL")
                  print(str)
               })
            }
            else
            {
               print("not a valid UTF-8 sequence")
            }
         }
         
         _instrument.sendCommand(GetName())
         { (response) -> Void in
            if let str = NSString(data: response.bytes, encoding: NSUTF8StringEncoding) as? String
            {
               print(str)
               
               dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                     self._name.text = self.mercuryStringFixup(str)
                     print("NAME")
                     print(str)
               })
            }
            else
            {
               print("not a valid UTF-8 sequence")
            }
         }
         
         _instrument.sendCommand(GetLocation())
         { (response) -> Void in
            if let str = NSString(data: response.bytes, encoding: NSASCIIStringEncoding) as? String
            {
               print(str)
                  
               dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                  //let newStr =
                  //str.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "\0"))
                        
                  self._location.text = self.mercuryStringFixup(str)
                        
                  print("LOCATION")
                  print(str)
               })
            }
            else
            {
               print("not a valid UTF-8 sequence")
            }
         }
      }
   }

   func connected()
   {
      print("connected")
   }

   func accept(access: MercuryAccess)
   {
      print("accept")
   }
   
   func stat(message: NSData!, withSubcommand subcommand: uint)
   {
      if(subcommand == RealTimeSignalStatus.rawValue)
      {
         //print("REALTIMESIGNALS")
         
         let response = MercuryRealTimeSignalsStatusResponse(message: message)
         
         //print(response.signals[ 8])
         //print(response.signals[75])
         
         dispatch_async(dispatch_get_main_queue(),
         { () -> Void in
               self._temperature.text = "\(response.signals[Int(IdTemperature.rawValue)])"
         })
      }
      
      if subcommand == ProcedureStatus.rawValue
      {
         let response = MercuryProcedureStatus(message: message)
         print(response.endStatus)
         print(response.runStatus)
         print(response.currentSegmentId)
         
         let runStatus = response.runStatus.rawValue
         dispatch_async(dispatch_get_main_queue(),
            { () -> Void in
               switch(runStatus)
               {
               case  0:
                  self._statusLabel.text = "Status: Idle"
               case 1:
                  self._statusLabel.text = "Status: PreTest"
               case 2:
                  self._statusLabel.text = "Status: Test"
               case 3:
                  self._statusLabel.text = "Status: PostTest"
               default:
                  self._statusLabel.text = ""
               }
               
         })
         
         print(self._statusLabel.text)
      }
   }
   
   func response(
      message: NSData!,
      withSequenceNumber sequenceNumber: uint,
      subcommand: uint,
      status: uint)
   {
      print("response")
      
      if (subcommand == 9)
      {
         let response = MercuryProcedureStatusResponse(message: message)
         print(response.endStatus)
         print(response.runStatus)
         print(response.currentSegmentId)
      }
   }
   
   func ackWithSequenceNumber(sequencenumber: uint)
   {
      print("ack")
   }
   
   func nakWithSequenceNumber(sequencenumber: uint, andError errorcode: uint)
   {
      print("nak")
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
   
}
