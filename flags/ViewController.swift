//
//  ViewController.swift
//  flags
//
//  Created by Artyom Mayorov on 1/5/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var answers = 0
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    let ok = UIAlertAction(title: "OK", style: .default)
    
    @IBAction func button1WasPressed(_ sender: UIButton) {
        
        if sender.imageView?.image == UIImage(named: countries[correctAnswer]) {
            self.score += 1
            answers += 1
            title = "Correct"
            navigationController!.navigationBar.backgroundColor = .green
            if answers <= 9 {
                let correctAlert = UIAlertController(title: "Correct", message: "Congratulations. You answered correctly", preferredStyle: .alert)
                self.present(correctAlert, animated: true)
                correctAlert.addAction(ok)
            } else {
                let restartGameButtonAlert = UIAlertAction(title: "Restart game", style: .default)
                let finalAlert = UIAlertController(title: "Game over", message: "Your final score is \(score).", preferredStyle: .alert)
                finalAlert.addAction(restartGameButtonAlert)
                self.present(finalAlert, animated: true)
                answers = 0
                score = 0
            }
        } else {
            title = "Wrong"
            self.score -= 1
            answers += 1
            navigationController!.navigationBar.backgroundColor = .red
            if answers <= 9 {
                let wrongAlert = UIAlertController(title: "Oops", message: "Sorry. You answered wrong! That’s the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
                self.present(wrongAlert, animated: true)
                wrongAlert.addAction(ok)
            } else {
                let restartGameButtonAlert = UIAlertAction(title: "Restart game", style: .default)
                let finalAlert = UIAlertController(title: "Game over", message: "Your final score is \(score).", preferredStyle: .alert)
                finalAlert.addAction(restartGameButtonAlert)
                self.present(finalAlert, animated: true)
                answers = 0
                score = 0
            }
            
        }
        askQuestion()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController!.navigationBar.backgroundColor = .white
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My score", style: .plain, target: self, action: #selector(showScore))
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        askQuestion()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "Where is: \(countries[correctAnswer].uppercased())?"
    }
    
    @objc func showScore() {
        let scoreAlert = UIAlertController(title: "Score", message: "Your score is \(score). \n Attempts: \(answers)", preferredStyle: .alert)
        self.present(scoreAlert, animated: true, completion: nil)
        scoreAlert.addAction(ok)
    }
    
}
