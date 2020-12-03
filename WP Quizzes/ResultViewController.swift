//
//  ResultViewController.swift
//  WP Quizzes
//
//  Created by Yuliia Olikhovska on 03/12/2020.
//

import UIKit

class ResultViewController: UIViewController {
    
    var score: Float?
    var guizID: Int?
    
    @IBOutlet var lableScore: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if score != nil {
            lableScore.text = "\(String(Int(score ?? 0)))%"
        }
    }

    
    @IBAction func buttonReturn() {
        let vc = self.storyboard?.instantiateViewController(identifier: "quiz") as! QuestionViewController
        vc.modalPresentationStyle = .fullScreen
        vc.quizID = self.guizID
        self.present(vc, animated: true)
    }
    
    @IBAction func buttonHome() {
//        let vc = self.storyboard?.instantiateViewController(identifier: "home") as! TableViewController
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
