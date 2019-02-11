//
//  ResultTVC.swift
//  JungleLife
//
//  Created by 李書賢 on 2019/2/11.
//  Copyright © 2019 Scott.com. All rights reserved.
//

import UIKit

class ResultTVC: UIViewController,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate {
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var filterList = [String]()
    var filterList2 = [String]()
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filterList.count ?? 0
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = filterList[indexPath.row]
        cell.detailTextLabel?.text = filterList2[indexPath.row]
        cell.imageView?.image = UIImage(named: filterList[indexPath.row] + "1")
        cell.backgroundColor = #colorLiteral(red: 0.7568627596, green: 0.5755516863, blue: 0.5688795421, alpha: 1)
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func updateSearchResults(for searchController: UISearchController) {
        filterList2 = []
        if let searchText = searchController.searchBar.text{
            filterList = appDelegate.list1.filter({ (string) -> Bool in
                return string.range(of: searchText) != nil
            })
            
            for i in filterList{
                let indexOfA = appDelegate.list1.firstIndex(of: i)
                filterList2.append(appDelegate.list2[indexOfA!])
            }
            
            myTableView.reloadData()
        }
    }
    
}
