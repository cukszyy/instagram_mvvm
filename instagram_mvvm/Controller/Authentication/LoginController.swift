import UIKit

class LoginController: UIViewController {
    
    private var viewModel = LoginViewModel()
    
    // MARK: - Properties
    
    private let iconImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "instagram_logo_white"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let emailTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Email")
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.configAuthenticationButton(title: "Log In")
        button.isEnabled = false
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private let forgotPasswordBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Forgot your password?  ", secondPart: "Get help signing in")
        return button
    }()
    
    private let signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have an account?  ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configInputObservers()
    }
    
    // MARK: - Helpers
    
    func configUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        configureGradientLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 20)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let textFieldStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginBtn, forgotPasswordBtn])
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 20
        view.addSubview(textFieldStackView)
        textFieldStackView.anchor(
            top: iconImage.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingBottom: 32,
            paddingRight: 32
        )
        
        view.addSubview(signUpBtn)
        signUpBtn.centerX(inView: view)
        signUpBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    func configInputObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // MARK: - Action
    
    @objc func login() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.login(withEmail: email, withPassword: password) { (result, err) in
            if let error = err {
                print("Failed to log in: \(error.localizedDescription)")
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func didTapSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        updateFormUI()
    }
}

// MARK: - FormViewModelProtocol

extension LoginController: FormViewModelProtocol {
    func updateFormUI() {
        loginBtn.backgroundColor = viewModel.buttonBackgroundColor
        loginBtn.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginBtn.isEnabled = viewModel.formIsValid
    }
}
