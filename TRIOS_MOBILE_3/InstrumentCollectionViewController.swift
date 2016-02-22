//
//  InstrumentCollectionViewController.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/20/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

class InstrumentCollectionViewController: UICollectionViewController
{
   var _instruments: [MercuryInstrument] = [];
   
   private let reuseIdentifier = "InstrumentCell"
   private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
      
      // Uncomment the following line to preserve selection between presentations
      // self.clearsSelectionOnViewWillAppear = false
      
      // Register cell classes
      //self.collectionView!.registerClass(
      //   UICollectionViewCell.self,
      //   forCellWithReuseIdentifier: reuseIdentifier)
      
      // Do any additional setup after loading the view.
   }
   
   @IBAction func addInstrument(sender: AnyObject)
   {
      //1. Create the alert controller.
      let alert = UIAlertController(
         title: "TA Instruments",
         message: "Enter instrument IP address.",
         preferredStyle: .Alert)
      
      //2. Add the text field. You can configure it however you need.
      alert.addTextFieldWithConfigurationHandler(
      { (textField) -> Void in
         textField.text = ""
      })
      
      //3. Grab the value from the text field, and print it when the user clicks OK.
      alert.addAction(
         UIAlertAction(
            title: "OK",
            style: .Default,
            handler:
            { (action) -> Void in
               let textField = alert.textFields![0] as UITextField
               
               let instrument:MercuryInstrument = MercuryInstrument()
               
               instrument.connectToHost(textField.text, andPort: 8080)
               
               instrument.loginWithUsername(
                  "NEW_AND_IMPROVED_IPAD",
                  machineName: "MAC",
                  ipAddress: "10.10.0.0",
                  access: 1000)
               
               self._instruments.append(instrument)
               
               self.collectionView?.reloadData()
            }))
      
      alert.addAction(
         UIAlertAction(
            title: "Cancel",
            style: .Default,
            handler:
            { (action) -> Void in
            }))

      // 4. Present the alert.
      self.presentViewController(alert, animated: true, completion: nil)
   }
   
   override func didReceiveMemoryWarning()
   {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using [segue destinationViewController].
   // Pass the selected object to the new view controller.
   }
   */
   
   // MARK: UICollectionViewDataSource
   
   override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
   {
      // #warning Incomplete implementation, return the number of sections
      return 1
   }
   
   
   override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   {
      // #warning Incomplete implementation, return the number of items
      return _instruments.count
   }
   
   override func collectionView(
      collectionView: UICollectionView,
      cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
   {
      let cell:InstrumentCell = collectionView.dequeueReusableCellWithReuseIdentifier(
         reuseIdentifier,
         forIndexPath: indexPath) as! InstrumentCell
      
      cell.instrument = _instruments[indexPath.row]
      
      return cell
   }
   
   // MARK: UICollectionViewDelegate
   
   override func collectionView(collection: UICollectionView, didSelectItemAtIndexPath selectedItemIndex: NSIndexPath)
   {
      //As sender send any data you need from the current Selected CollectionView
      self.performSegueWithIdentifier("InstrumentSegue", sender: self)
   }
   
   /*
   // Uncomment this method to specify if the specified item should be highlighted during tracking
   override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool
   {
   return true
   }
   */
   
   /*
   // Uncomment this method to specify if the specified item should be selected
   override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool
   {
   return true
   }
   */
   
   /*
   // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
   override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool
   {
   return false
   }
   
   override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool
   {
   return false
   }
   
   override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?)
   {
   
   }
   */
}
