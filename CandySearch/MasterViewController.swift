/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class MasterViewController: UITableViewController {
  
  // MARK: - Properties
  var detailViewController: DetailViewController? = nil
  var candies = [Candy]()
  var filteredCandies = [Candy]()
  let searchController = UISearchController(searchResultsController: nil)
    var currentIndex:Int = 0
    var objects:[String] = [String]()
    var masterView:MasterViewController?
    let kNotes:String = "notes"
    let BLANK_NOTE:String = "(New Note)"
    
    
  // var newCandy = DetailViewController? = nil
    //i was attempting to make a variable to enable to call that edit screen (detailViewController) in my InsertNewObjectFunction
    
  // MARK: - View Setup
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Setup Bar Button item
    self.navigationItem.leftBarButtonItem = self.editButtonItem()
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton
    
    // Setup the Search Controller
    searchController.searchBar.scopeButtonTitles = [""]
    
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    definesPresentationContext = true
    searchController.dimsBackgroundDuringPresentation = false
    
    tableView.tableHeaderView = searchController.searchBar
    
    candies = [
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:""),
      Candy(category:"user input", name:"")]
    
    if let splitViewController = splitViewController {
      let controllers = splitViewController.viewControllers
      detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    
    clearsSelectionOnViewWillAppear = splitViewController!.collapsed
    super.viewWillAppear(animated)
  }
  
    // add controller function
    
    func insertNewObject(sender: UIBarButtonItem) {
        /* makes blnak note appear if your are no inputs already*/
        if objects.count == 0 || objects[0] != BLANK_NOTE {
            /////////////////////////////////////
            objects.insert(BLANK_NOTE, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        currentIndex = 0
        self.performSegueWithIdentifier("showDetail", sender: self)
    }


    
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
    
    
  
  // MARK: - Table View
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchController.active && searchController.searchBar.text != "" {
      return filteredCandies.count
    }
    return candies.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    let candy: Candy
    if searchController.active && searchController.searchBar.text != "" {
      candy = filteredCandies[indexPath.row]
    } else {
      candy = candies[indexPath.row]
    }
    cell.textLabel!.text = candy.name
    cell.detailTextLabel!.text = candy.category
    return cell
  }
  
  func filterContentForSearchText(searchText: String, scope: String = "All") {
    filteredCandies = candies.filter({( candy : Candy) -> Bool in
      let categoryMatch = (scope == "All") || (candy.category == scope)
      return categoryMatch && candy.name.lowercaseString.containsString(searchText.lowercaseString)
    })
    tableView.reloadData()
  }
    //////deletebutton function
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
  
  // MARK: - Segues
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // if segue.identifier == "showDetail" {
    
    //search controller
      if let indexPath = tableView.indexPathForSelectedRow {
        let candy: Candy
        if searchController.active && searchController.searchBar.text != "" {
          candy = filteredCandies[indexPath.row]
            
        } else {
            
          candy = candies[indexPath.row]
        }
        
        let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
        controller.detailCandy = candy
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        controller.navigationItem.leftItemsSupplementBackButton = true
      }
    }
  
  
}

extension MasterViewController: UISearchBarDelegate {
  // MARK: - UISearchBar Delegate
  func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
    filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
  }
}

extension MasterViewController: UISearchResultsUpdating {
  // MARK: - UISearchResultsUpdating Delegate
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    let searchBar = searchController.searchBar
    let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
    filterContentForSearchText(searchController.searchBar.text!, scope: scope)
  }
}