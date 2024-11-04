//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Ana Oganesiani on 03.11.24.
//

import Foundation
import UIKit

class QuestionViewController: UIViewController {
    
    var question: Question? // მიღებული შეკითხვა
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 40/255, alpha: 1) // ფონტისთვის მუქი ფერი
        setupUI()
    }
    
    private func setupUI() {
        // UI ელემენტების კონფიგურაცია შეკითხვის და პასუხების ჩვენებისთვის
        guard let question = question else { return }
        
        // მაგალითი - შეკითხვის ლეიბლი
        let questionLabel = UILabel()
        questionLabel.text = question.question
        questionLabel.textColor = .white
        questionLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 0
        view.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // აქ ასევე დაემატება პასუხების ღილაკები და სხვა UI კომპონენტები
    }
}
