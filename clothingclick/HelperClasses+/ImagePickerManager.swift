//
//  ImagePickerManager.swift
//  clothingclick
//
//  Created by DavidBisht on 11/05/26.
//
import SwiftUI
import PhotosUI
import UIKit
import Combine

// MARK: - Selection Type

enum ImageSelectionType {
    case single
    case multiple
}

// MARK: - Source Type

enum PickerSource {
    case camera
    case gallery
}

// MARK: - Image Picker Manager

@MainActor
final class ImagePickerManager: ObservableObject {

    // MARK: - Published Properties

    @Published var selectedImage: UIImage?
    @Published var selectedImages: [UIImage] = []

    @Published var showSourceDialog = false
    @Published var showCamera = false
    @Published var showGallery = false

    // Gallery Picker
    @Published var photoItem: PhotosPickerItem?
    @Published var photoItems: [PhotosPickerItem] = []

    // Config
    var selectionType: ImageSelectionType = .single

    // MARK: - Open Picker

    func openPicker(type: ImageSelectionType) {
        self.selectionType = type
        showSourceDialog = true
    }

    // MARK: - Handle Source

    func handleSource(_ source: PickerSource) {

        switch source {

        case .camera:
            showCamera = true

        case .gallery:
            showGallery = true
        }
    }

    // MARK: - Load Single Image

    func loadSingleImage() async {

        guard let photoItem else { return }

        do {

            if let data = try await photoItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {

                self.selectedImage = image
            }

        } catch {
            print("Single Image Error:", error)
        }
    }

    // MARK: - Load Multiple Images

    func loadMultipleImages() async {

        selectedImages.removeAll()

        do {

            for item in photoItems {

                if let data = try await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data) {

                    selectedImages.append(image)
                }
            }

        } catch {
            print("Multiple Image Error:", error)
        }
    }

    // MARK: - Camera Result

    func setCameraImage(_ image: UIImage?) {

        guard let image else { return }

        switch selectionType {

        case .single:
            selectedImage = image

        case .multiple:
            selectedImages.append(image)
        }
    }
}

// MARK: - UIKit Camera Picker

struct CameraPicker: UIViewControllerRepresentable {

    var completion: (UIImage?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: Context) {
    }

    final class Coordinator: NSObject,
                             UINavigationControllerDelegate,
                             UIImagePickerControllerDelegate {

        var completion: (UIImage?) -> Void

        init(completion: @escaping (UIImage?) -> Void) {
            self.completion = completion
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

            let image = info[.originalImage] as? UIImage

            picker.dismiss(animated: true)
            completion(image)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

            picker.dismiss(animated: true)
            completion(nil)
        }
    }
}
