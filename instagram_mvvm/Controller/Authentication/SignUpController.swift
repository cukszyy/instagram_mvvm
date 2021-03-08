import UIKit

class SignUpController: UIViewController {
    
    // MARK: - Properties
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add_photo"), for: .normal)
        button.tintColor = .white
        return button
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
    
    private let fullnameTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Fullname")
        return textField
    }()
    
    private let usernameTextField: UITextField = {
        let textField = CustomTextField(placeholder: "Username")
        return textField
    }()
    
    private let signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.configAuthenticationButton(title: "Sign Up")
        return button
    }()
    
    private let signInBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account?  ", secondPart: "Sign In")
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    // MARK: - Helpers
    
    func configUI() {
        configureGradientLayer()
        
        view.addSubview(addPhotoButton)
        addPhotoButton.centerX(inView: view)
        addPhotoButton.setDimensions(height: 140, width: 140)
        addPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let textFieldStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, fullnameTextField, usernameTextField, signUpBtn])
        textFieldStackView.axis = .vertical
        textFieldStackView.spacing = 20
        view.addSubview(textFieldStackView)
        textFieldStackView.anchor(
            top: addPhotoButton.bottomAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingTop: 32,
            paddingLeft: 32,
            paddingBottom: 32,
            paddingRight: 32
        )
        
        view.addSubview(signInBtn)
        signInBtn.centerX(inView: view)
        signInBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    // MARK: - Sign In
    
    @objc func didTapSignIn() {
        navigationController?.popViewController(animated: true)
    }
}
