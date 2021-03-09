import UIKit

class SignUpController: UIViewController {
    
    private var viewModel = SignUpViewModel()
    
    // MARK: - Properties
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "add_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapAddPhoto), for: .touchUpInside)
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
        button.isEnabled = false
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
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
        configInputObservers()
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
    
    func configInputObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // MARK: - Actions
    
    @objc func didTapSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        guard let username = usernameTextField.text?.lowercased() else { return }
        guard let profileImage = addPhotoButton.currentImage else { return }
        
        let credentials = AuthCredentials(
            email: email,
            password: password,
            fullname: fullname,
            username: username,
            profileImage: profileImage
        )
        
        AuthService.registerUser(withCredential: credentials) { err in
            if let error = err {
                print("Failed to register user \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func didTapSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == usernameTextField {
            viewModel.username = sender.text
        }
        updateFormUI()
    }
    
    @objc func didTapAddPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
}

// MARK: - FormViewModelProtocol

extension SignUpController: FormViewModelProtocol {
    func updateFormUI() {
        signUpBtn.backgroundColor = viewModel.buttonBackgroundColor
        signUpBtn.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpBtn.isEnabled = viewModel.formIsValid
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        
        addPhotoButton.layer.cornerRadius = addPhotoButton.frame.width / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderWidth = 2
        addPhotoButton.layer.borderColor = UIColor.black.cgColor
        addPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
