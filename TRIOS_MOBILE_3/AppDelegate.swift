//
//  AppDelegate.swift
//  TRIOS_MOBILE_3
//
//  Created by stephen eshelman on 2/20/16.
//  Copyright © 2016 objectthink.com. All rights reserved.
//

import UIKit

protocol MercuryHasInstrumentProtocol:class
{
   var instrument:MercuryInstrument {get set}
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?


   func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
   {
      // Override point for customization after application launch.
   
      // Actions
      let firstAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
      firstAction.identifier = "FIRST_ACTION"
      firstAction.title = "First Action"
      
      firstAction.activationMode = UIUserNotificationActivationMode.Background
      firstAction.destructive = true
      firstAction.authenticationRequired = false
      
      let secondAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
      secondAction.identifier = "SECOND_ACTION"
      secondAction.title = "Second Action"
      
      secondAction.activationMode = UIUserNotificationActivationMode.Foreground
      secondAction.destructive = false
      secondAction.authenticationRequired = false
      
      let thirdAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
      thirdAction.identifier = "THIRD_ACTION"
      thirdAction.title = "Third Action"
      
      thirdAction.activationMode = UIUserNotificationActivationMode.Background
      thirdAction.destructive = false
      thirdAction.authenticationRequired = false
      
      
      // category
      
      let firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
      firstCategory.identifier = "FIRST_CATEGORY"
      
      let defaultActions:NSArray = [firstAction, secondAction, thirdAction]
      let minimalActions:NSArray = [firstAction, secondAction]
      
      firstCategory.setActions(defaultActions as? [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Default)
      firstCategory.setActions(minimalActions as? [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Minimal)
      
      // NSSet of all our categories
      
      let categories:NSSet = NSSet(objects: firstCategory)
      
      let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge], categories: categories as? Set<UIUserNotificationCategory>)
      
      UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
      
      return true
   }
   
   func application(application: UIApplication,
      handleActionWithIdentifier identifier:String?,
      forLocalNotification notification:UILocalNotification,
      completionHandler: (() -> Void)){
         
         if (identifier == "FIRST_ACTION")
         {
            
         }
         else if (identifier == "SECOND_ACTION")
         {
         }
         
         completionHandler()
         
   }

   func applicationWillResignActive(application: UIApplication)
   {
      // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
      // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   }

   func applicationDidEnterBackground(application: UIApplication)
   {
      // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
      // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
      
      let now = NSDate()
      let date = now.dateByAddingTimeInterval(5)
      
      let notification:UILocalNotification = UILocalNotification()
      
      notification.category = "FIRST_CATEGORY"
      notification.alertBody = "Test ended successfully!"
      notification.fireDate = date
      
      UIApplication.sharedApplication().scheduleLocalNotification(notification)
   }

   func applicationWillEnterForeground(application: UIApplication)
   {
      // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   }

   func applicationDidBecomeActive(application: UIApplication)
   {
      // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   }

   func applicationWillTerminate(application: UIApplication)
   {
      // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
   }


}

