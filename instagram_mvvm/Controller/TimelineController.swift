import UIKit
import Firebase

private let reuseIdentifier = "timelineCell"

class TimelineController: UICollectionViewController {
    
    // MARK: - Lifecycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        collectionView.register(TimelineCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: - Helpers
    
    func configUI() {
        collectionView.backgroundColor = .white
        navigationItem.title = "Timeline"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        navigationItem.rightBarButtonItem?.tintColor = .secondaryLabel
    }
    
    // MARK: - Actions
    
    @objc func logout() {
        do {
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("Failed to sign out")
        }
    }
}

// MARK: - UICollectionViewDataSource

extension TimelineController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TimelineCell
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension TimelineController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8 // Padding + Avatar
        height += 50 // PostImage
        height += 60 // Buttons and comments
        
        return CGSize(width: width, height: height)
    }
}
