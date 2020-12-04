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
        
        let urlString = "http://quiz.o2.pl/api/v1/quizzes/0/100"
        request(urlString: urlString)
        overrideUserInterfaceStyle = .light
    }
    
    //MARK: - Parsing JSON
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
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        guard let item = self.items?[indexPath.row] else { return cell }
        
        let strokeTextAttributes: [NSAttributedString.Key : Any] = [
            .strokeColor : UIColor.black,
            .foregroundColor : UIColor.white,
            .strokeWidth : -2.0,
        ]
        cell.titleLabel.attributedText = NSAttributedString(string: item.title, attributes: strokeTextAttributes)
        
        let urlImageString = (item.mainPhoto.url.replacingOccurrences(of: "https://", with: "http://i.wpimg.pl/414x200/"))
        guard let urlImage = URL(string: urlImageString) else { return cell }
        cell.imageLabel.sd_setImage(with: urlImage, placeholderImage: #imageLiteral(resourceName: "placeHolder"), options: [.progressiveLoad], completed: nil)
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuiz" {
            let vc = segue.destination as! QuestionViewController
            //let cell = sender as! TableViewCell
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let item = self.items?[indexPath.row] else { return }
            vc.quizID = item.id
        }
    }
    
}
