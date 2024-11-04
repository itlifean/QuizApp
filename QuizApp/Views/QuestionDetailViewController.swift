
import UIKit

class QuestionDetailViewController: UIViewController {
    
    var questionData: [String: Any] = [:]
    private let userDefaults = UserDefaults.standard
    private var options: [String] = []
    private var correctAnswer: String = ""
    private var selectedAnswerIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 40/255, alpha: 1)
        setupScrollView()
        loadQuestionData()
    }
    
    private func loadQuestionData() {
        guard let questionText = questionData["question"] as? String,
              let correct = questionData["correct_answer"] as? String,
              let incorrectAnswers = questionData["incorrect_answers"] as? [String] else { return }
        
        correctAnswer = correct
        options = incorrectAnswers + [correctAnswer]  // Combine correct and incorrect answers
        options.shuffle()  // Shuffle options to randomize position
        
        setupQuestionLabel(text: questionText)
        setupOptions()
        setupScoreView()
    }
    
    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupQuestionLabel(text: String) {
        let questionLabel = UILabel()
        questionLabel.text = text
        questionLabel.font = UIFont.systemFont(ofSize: 24)
        questionLabel.textColor = .white
        questionLabel.numberOfLines = 0
        questionLabel.textAlignment = .center
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionLabel)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupOptions() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        for (index, option) in options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.tag = index
            button.backgroundColor = .white
            button.setTitleColor(UIColor(red: 0.5, green: 0.3, blue: 1.0, alpha: 1), for: .normal)
            button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        selectedAnswerIndex = sender.tag
        let selectedAnswer = options[selectedAnswerIndex!]
        let isCorrect = selectedAnswer == correctAnswer
        let key = isCorrect ? "correctAnswers" : "incorrectAnswers"
        let currentCount = userDefaults.integer(forKey: key)
        userDefaults.set(currentCount + 1, forKey: key)
        
        for (index, button) in sender.superview!.subviews.enumerated() where button is UIButton {
            let answerButton = button as! UIButton
            answerButton.backgroundColor = index == selectedAnswerIndex ? UIColor(red: 0.5, green: 0.3, blue: 1.0, alpha: 1) : .white
            answerButton.setTitleColor(index == selectedAnswerIndex ? .white : UIColor(red: 0.5, green: 0.3, blue: 1.0, alpha: 1), for: .normal)
        }
    }
    
    private func setupScoreView() {
        let correctCount = userDefaults.integer(forKey: "correctAnswers")
        let incorrectCount = userDefaults.integer(forKey: "incorrectAnswers")
        
        let scoreLabel = UILabel()
        scoreLabel.text = "Correct Answer \(correctCount) / Incorrect \(incorrectCount)"
        scoreLabel.textColor = .white
        scoreLabel.textAlignment = .center
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreLabel)
        
        NSLayoutConstraint.activate([
            scoreLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
