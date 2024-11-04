
import UIKit

class QuizListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView = UITableView()
    private var questions: [[String: Any]] = []
    private let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 40/255, alpha: 1)
        setupTitleLabel()
        setupTableView()
        setupResetButton()
        loadQuestions()
    }
    
    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.text = "Quiz"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupResetButton() {
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor(red: 0.5, green: 0.3, blue: 1.0, alpha: 1)
        resetButton.layer.cornerRadius = 15
        resetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(resetScore), for: .touchUpInside)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func loadQuestions() {
        // Load questions from JSON file
        if let path = Bundle.main.path(forResource: "Questions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let results = json["results"] as? [[String: Any]] {
                    questions = results
                }
            } catch {
                print("Error loading questions from JSON: \(error)")
            }
        }
        tableView.reloadData()
    }
    
    @objc private func resetScore() {
        userDefaults.set(0, forKey: "correctAnswers")
        userDefaults.set(0, forKey: "incorrectAnswers")
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        if let questionText = questions[indexPath.row]["question"] as? String {
            cell.textLabel?.text = questionText
        }
        cell.textLabel?.textColor = UIColor(red: 0.5, green: 0.3, blue: 1.0, alpha: 1)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = QuestionDetailViewController()
        detailVC.questionData = questions[indexPath.row]  // Pass the entire question data object
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
