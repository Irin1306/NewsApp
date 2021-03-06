//
//  TableViewController.swift
//  NewsApp
//
//  Created by USER on 03/10/2018.
//  Copyright © 2018 My. All rights reserved.
//

import UIKit



class NewsTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var cellImageView: UIImageView!
    
     
    @IBOutlet weak var cellPublishedAtTextLabel: UILabel!
    
    
    @IBOutlet weak var cellTitleTextLabel: UILabel!
    
    @IBOutlet weak var cellDescriptionTextLabel: UILabel!
}

class TableViewController: UITableViewController {
    
    var articles = [[String: Any]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.groupTableViewBackground
       
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        DataService.shared.getData{ (data) in
           
           self.articles = data            
           self.tableView.reloadData()
       
        }
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as! NewsTableViewCell
        
        // Configure the cell...
        let currentItem = articles[indexPath.row]
        var image = UIImage()

        if let imageUrl = currentItem["urlToImage"] {
            let url = URL(string: imageUrl as! String)
            let data = try? Data(contentsOf: url!)
            image = UIImage(data: data!)!
            
        } else {
            //image = UIImage(named: "emptyImage")!
            
        }
        cell.cellImageView?.image = image
        cell.cellTitleTextLabel?.text = currentItem["title"] as? String
        if let date = currentItem["description"] {
            let space: String = "\t"
        cell.cellDescriptionTextLabel?.text = space + (date as! String)
        }
        if let date = currentItem["publishedAt"] {
            let str = date as! String
            let substr = String(str[..<str.index(str.startIndex, offsetBy: 10)])
            cell.cellPublishedAtTextLabel?.text = substr
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentItem = articles[indexPath.row]
        
        if let path = currentItem["url"] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let webvc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webvc.urlpath = path as! String
            navigationController?.pushViewController(webvc, animated: true)
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */ 
    
    
    

}
