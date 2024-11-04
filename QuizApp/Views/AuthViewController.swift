import UIKit

class AuthViewController: UIViewController {
    
    // Интерфейсные элементы
    private let usernameLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordLabel = UILabel()
    private let passwordField = UITextField()
    private let confirmPasswordLabel = UILabel()
    private let confirmPasswordField = UITextField()
    private let loginButton = UIButton(type: .system)
    private let iconImageView = UIImageView(image: UIImage(systemName: "person.crop.circle.badge.plus"))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 20/255, green: 20/255, blue: 40/255, alpha: 1)
        
        // Проверка пароля в Keychain
        checkForSavedPassword()
        
        setupUI()
    }
    
    private func setupUI() {
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(iconImageView)
        
        setupLabel(usernameLabel, text: "Username")
        setupTextField(usernameField, placeholder: "Enter username")
        
        setupLabel(passwordLabel, text: "Password")
        setupTextField(passwordField, placeholder: "Enter password")
        
        setupLabel(confirmPasswordLabel, text: "Confirm password")
        setupTextField(confirmPasswordField, placeholder: "Enter password")
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: 142/255, green: 132/255, blue: 255/255, alpha: 1)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 0.3
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 4)
        loginButton.layer.shadowRadius = 4
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func checkForSavedPassword() {
        if let _ = KeychainHelper.shared.getPassword(for: "userPassword") {
            navigateToMainScreen()
        }
    }
    
    @objc private func loginButtonTapped() {
        guard let password = passwordField.text, !password.isEmpty,
              let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty,
              password == confirmPassword else {
            print("Password confirmation failed")
            return
        }
        
        KeychainHelper.shared.savePassword(password, for: "userPassword")
        print("Password saved to Keychain")
        
        navigateToMainScreen()
    }
    
    private func navigateToMainScreen() {
        let mainVC = QuizListViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    private func setupLabel(_ label: UILabel, text: String) {
        label.text = text
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
    }
    
    private func setupTextField(_ textField: UITextField, placeholder: String) {
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .white
        textField.layer.shadowColor = UIColor.black.cgColor
        textField.layer.shadowOpacity = 0.1
        textField.layer.shadowOffset = CGSize(width: 0, height: 2)
        textField.layer.shadowRadius = 4
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        textField.leftViewMode = .always
        view.addSubview(textField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 160),
            iconImageView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 40),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            usernameField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordLabel.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 5),
            confirmPasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmPasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 60),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
