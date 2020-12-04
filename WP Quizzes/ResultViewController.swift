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

}
