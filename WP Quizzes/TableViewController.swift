//
//  TableViewController.swift
//  WP Quizzes
//
//  Created by Yuliia Olikhovska on 02/12/2020.
//

import UIKit
import SDWebImage

class TableViewController: UITableViewController {
    var items: [Item]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let urlString = "http://quiz.o2.pl/api/v1/quizzes/0/100"
        request(urlString: urlString)
    }
    
    //MARK: - Parsing
    func request(urlString: String) -> Void {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let quizzes = try JSONDecoder().decode(Quizzes.self, from: data)
                self.items = quizzes.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let jsonError {
                print("error json", jsonError)
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items?.count ?? 0
        //return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        
        guard let item = self.items?[indexPath.row] else { return cell }
        
        //cell.titleLabel.text = item.title
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .strokeWidth : -2.0,
            ]
        cell.titleLabel.attributedText = NSAttributedString(string: item.title, attributes: strokeTextAttributes)
        
        let urlImageString = item.mainPhoto.url.replacingOccurrences(of: "https://", with: "http://i.wpimg.pl/414x200/")
        guard let urlImage = URL(string: urlImageString) else { return cell }
        cell.imageLabel.sd_setImage(with: urlImage, placeholderImage: #imageLiteral(resourceName: "Без названия"), options: [.progressiveLoad], completed: nil)

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

}
