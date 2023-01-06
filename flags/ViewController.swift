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
    
    @IBAction func button1WasPressed(_ sender: UIButton) {
//        var title: String
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        if answers == 10 {
            let finalAlert = UIAlertController(title: "Game over", message: "Your final score is \(score)" , preferredStyle: .alert)
            self.present(finalAlert, animated: true)
        }
        
        if sender.imageView?.image == UIImage(named: countries[correctAnswer]) {
            title = "Correct"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController!.navigationBar.backgroundColor = .white
            }
            navigationController!.navigationBar.backgroundColor = .green
            let correctAlert = UIAlertController(title: "Correct", message: "Congratulations. You are answered right!", preferredStyle: .alert)
            self.present(correctAlert, animated: true, completion: askQuestion)
            correctAlert.addAction(ok)
            self.score += 1
        } else {
            title = "Wrong"
            self.score -= 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController!.navigationBar.backgroundColor = .white
            }
            navigationController!.navigationBar.backgroundColor = .red
            let wrongAlert = UIAlertController(title: "Oops", message: "Sorry. You are answered wrong! That’s the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            self.present(wrongAlert, animated: true, completion: askQuestion)
            wrongAlert.addAction(ok)
        }
        
        answers += 1
    }
    
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var answers = 0
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "My score", style: .plain, target: self, action: #selector(heyho))
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
    
    @objc func heyho() {
        let scoreAlert = UIAlertController(title: "Score", message: "Your score is \(score)", preferredStyle: .alert)
        self.present(scoreAlert, animated: true, completion: nil)
        let ok = UIAlertAction(title: "OK", style: .default)
        scoreAlert.addAction(ok)
    }

}
