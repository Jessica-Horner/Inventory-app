

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {
    
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    // Override point for customization after application launch.
    let splitViewController = window!.rootViewController as! UISplitViewController
    let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
    navigationController.topViewController!.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
    splitViewController.delegate = self
    
    UISearchBar.appearance().barTintColor = UIColor.candyGreen()
    UISearchBar.appearance().tintColor = UIColor.whiteColor()
    UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchBar.self]).tintColor = UIColor.candyGreen()
    return true
  }
    
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
        
    func applicationDidEnterBackground(application: UIApplication) {
        
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    
    }
    
    func applicationDidBecomeActive(application: UIApplication) {

    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }

  
  // MARK: - Split view
  /*func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
    guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
    guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
    if topAsDetailController.detailCandy == nil {
      // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
      return true
    }
    return false
  }*/
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
        guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
        if topAsDetailController.detailCandy == nil {
            // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
            return true
        }
        return false
    }
  
}
extension UIColor {
  static func candyGreen() -> UIColor {
    return UIColor(red: 17, green: 85, blue: 12, alpha: 9.0)
  }
}

