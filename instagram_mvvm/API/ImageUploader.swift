import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let error = err {
                print("Failed to upload image \(error.localizedDescription)")
            }
            
            ref.downloadURL { (url, urlErr) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
        
    }
}
