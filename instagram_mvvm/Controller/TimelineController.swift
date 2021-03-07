import UIKit

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
