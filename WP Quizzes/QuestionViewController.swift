//
//  QuestionViewController.swift
//  WP Quizzes
//
//  Created by Yuliia Olikhovska on 03/12/2020.
//

import UIKit
import SDWebImage

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var quizID: Int?
    var questions: [Question]?
    var currentQuestion: Question?
    var score: Float = 0.0
    
    @IBOutlet var label: UILabel!
    @IBOutlet var progress: UIProgressView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        guard let id = quizID else { return }
        let urlString = "http://quiz.o2.pl/api/v1/quiz/\(id)/0"
        request(urlString: urlString)
        progress.progress = 0.0
        overrideUserInterfaceStyle = .light
    }
    
    private func configureUI(question: Question) {
        DispatchQueue.main.async {
            
            self.label.text = question.text
            if question.image.url != "" {
                let urlImageString = question.image.url.replacingOccurrences(of: "https://", with: "http://i.wpimg.pl/414x200/")
                guard let urlImage = URL(string: urlImageString) else { return }
                self.image.sd_setImage(with: urlImage, placeholderImage: #imageLiteral(resourceName: "placeHolder"), options: [.progressiveLoad], completed: nil)
            }
            self.currentQuestion = question
            self.table.reloadData()
        }
        
    }
    
    //MARK: - Parsing JSON
    private func request(urlString: String) -> Void {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            do {
                let quiz = try JSONDecoder().decode(Quiz.self, from: data)
                self.questions = quiz.questions
                guard let question = self.questions?.first else { return }
                self.configureUI(question: question)
            } catch let jsonError {
                print("error json", jsonError)
            }
        }.resume()
    }
    
    //MARK: - Table view functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        cell.contentView.backgroundColor = UIColor.white
        tableView.allowsSelection = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        guard let question = currentQuestion else { return }
        guard let answer = currentQuestion?.answers[indexPath.row] else { return }
        guard let questionsCount = questions?.count else { return }
        
        if answer.isCorrect != nil {
            UIView.animate(withDuration: 0.3, animations: {
                cell.contentView.backgroundColor = UIColor.green
                self.score += 1
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                cell.contentView.backgroundColor = UIColor.red
            })
        }
        tableView.allowsSelection = false
        if let index = questions?.firstIndex(where: { $0.order == question.order}) {
            if index < (questionsCount - 1) {
                let nextQuestion = questions![index + 1]
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    self.progress.progress += 1.0 / Float(questionsCount)
                    self.configureUI(question: nextQuestion)
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
                    let vc = self.storyboard?.instantiateViewController(identifier: "result") as! ResultViewController
                    vc.modalPresentationStyle = .fullScreen
                    vc.guizID = self.quizID
                    vc.score = (self.score / Float(questionsCount)) * 100
                    self.present(vc, animated: true)
                }
            }
        }
    }
    
}
