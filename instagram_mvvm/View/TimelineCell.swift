import UIKit

class TimelineCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private lazy var username: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .purple
        return imageView
    }()
    
    private lazy var likeBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var commentBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private lazy var shareBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Likes"
        label.font = UIFont.boldSystemFont(ofSize: 13.0)
        label.textColor = .black
        return label
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Image caption"
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        return label
    }()
    
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "1 hour ago"
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textColor = .lightGray
        return label
    }()
        
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(username)
        username.centerY(
            inView: profileImageView,
            leftAnchor: profileImageView.rightAnchor,
            paddingLeft: 10.0
        )
        
        addSubview(postImageView)
        postImageView.anchor(
            top: profileImageView.bottomAnchor,
            left: leftAnchor,
            right: rightAnchor,
            paddingTop: 8.0
        )
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0).isActive = true
        
        configActionButtons()
        
        addSubview(likeCountLabel)
        likeCountLabel.anchor(
            top: likeBtn.bottomAnchor,
            left: leftAnchor,
            paddingTop: -4,
            paddingLeft: 8.0
        )
        
        addSubview(captionLabel)
        captionLabel.anchor(
            top: likeCountLabel.bottomAnchor,
            left: leftAnchor,
            paddingTop: 8.0,
            paddingLeft: 8.0
        )
        
        addSubview(postTimeLabel)
        postTimeLabel.anchor(
            top: captionLabel.bottomAnchor,
            left: leftAnchor,
            paddingTop: 8.0,
            paddingLeft: 8.0
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configActionButtons() { 
        let buttonStackView = UIStackView(arrangedSubviews: [likeBtn, commentBtn, shareBtn])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        addSubview(buttonStackView)
        buttonStackView.anchor(top: postImageView.bottomAnchor, width: 120.0, height: 50.0)
    }
    
    // MARK: - Actions
    
    @objc func didTapUsername() {
        print("func: didTapUsername()")
    }
}
