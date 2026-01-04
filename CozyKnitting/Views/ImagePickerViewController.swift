import UIKit

final class ImagePickerViewController: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private weak var presentationController: UIViewController?
    private var completion: ((UIImage?) -> Void)?

    init(presentationController: UIViewController) {
        self.presentationController = presentationController
    }

    func presentImagePicker(completion: @escaping (UIImage?) -> Void) {
        self.completion = completion

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary

        presentationController?.present(picker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        let image = info[.originalImage] as? UIImage
        completion?(image)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
