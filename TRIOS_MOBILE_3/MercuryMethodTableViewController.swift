//
//  MercuryMethodTableViewController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/28/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class MercuryMethodTableViewController: UITableViewController, MercuryInstrumentDelegate, MercuryHasInstrumentProtocol
{
   var _instrument:MercuryInstrument!
   var _procedureResponse:MercuryGetProcedureResponse!
   
   var instrument:MercuryInstrument
      {
      get { return _instrument }
      set
      {
         _instrument = newValue
         
         _instrument.sendCommand(MercuryGetProcedureCommand())
         { (r) -> Void in
               
               let response = MercuryGetProcedureResponse(message: NSData(data: r.bytes))
            
               self._procedureResponse = response
            
               for segment in response.segments
               {
                  print(segment.description)
               }
            
               dispatch_async(dispatch_get_main_queue(),
               { () -> Void in
                  self.tableView.reloadData()
               })
         }

      }
   }
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false
      
      // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
      // self.navigationItem.rightBarButtonItem = self.editButtonItem()
   }
   
   override func viewDidDisappear(animated: Bool)
   {
      _instrument.removeDelegate(self)
   }
   
   override func viewDidAppear(animated: Bool)
   {
      _instrument.addDelegate(self)
   }
   
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   // MARK: - Table view data source
   
   override func numberOfSectionsInTableView(tableView: UITableView) -> Int
   {
      // #warning Incomplete implementation, return the number of sections
      return 1
   }
   
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
   {
      // #warning Incomplete implementation, return the number of rows
      if _procedureResponse == nil
      {
         return 0
      }
      else
      {
         return _procedureResponse.segments.count
      }
   }
   
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCellWithIdentifier("segmentCell", forIndexPath: indexPath)
      
      // Configure the cell...
      cell.textLabel!.text = _procedureResponse.segments[indexPath.row].name
      
      return cell
   }
   
   /*
   // Override to support conditional editing of the table view.
   override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
   
   /*
   // Override to support editing the table view.
   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
   if editingStyle == .Delete {
   // Delete the row from the data source
   tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
   } else if editingStyle == .Insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
   
   /*
   // Override to support rearranging the table view.
   override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
   
   }
   */
   
   /*
   // Override to support conditional rearranging of the table view.
   override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
   
   /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
   // MARK: - MercuryInstrumentDelegate
   
   func stat(message: NSData!, withSubcommand subcommand: uint)
   {
      if(subcommand == RealTimeSignalStatus.rawValue)
      {
         print("REALTIMESIGNALS IN MERCURY METHOD TABLE VIEW CONTROLLER !!!!!!")
         
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
}
