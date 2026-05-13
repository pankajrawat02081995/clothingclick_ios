//
//  EditStoreProfileView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI
import PhotosUI

struct EditStoreProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = EditStoreProfileViewModel()
    @FocusState private var focusedField: Field?
    @FocusState private var isBioField: Bool
    @StateObject private var imagePicker = ImagePickerManager()
    @State private var isActiveStoreHoursView: Bool = false
    @State private var isActiveLocationView: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    ScrollViewReader { ScrollViewProxy in
                        VStack(spacing: 20) {
                            profileSection
                            fieldsSection
                            addressSection
                            operatingHoursSection
                            contactInformationSection
                        }
                        .padding()
                    }
                }
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                saveButton
                    .padding()
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: "Aman",
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        dismiss()
                    }
                )
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var profileSection: some View {
        VStack {
            if let image = vm.storeProfilePicture {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .overlay {
                        Circle()
                            .fill(AppColor.clearColor)
                            .stroke(AppColor.borderColor, lineWidth: 1)
                    }
            } else {
                Text(vm.storename.prefix(1).capitalized)
                    .font(AppFont.medium.font(size: 32))
                    .foregroundStyle(AppColor.whiteColor)
                    .frame(width: 110, height: 110)
                    .background(AppColor.blackColor)
                    .clipShape(Circle())
            }
            Text(Constants.changePhoto)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
                .onTapGesture {
                    
                }
        }
    }
    
    private var fieldsSection: some View {
        VStack(spacing: 10) {
            textFieldWithTitle(Constants.enterHere, text: $vm.storename, title: Constants.storeName.capitalized, focusStateField: .storenameField)
            textFieldWithTitle(Constants.enterHere, text: $vm.storename, title: Constants.storeName, focusStateField: .storenameField)
            featurePhotoSection
            textEditorWithTitle(Constants.enterHere, text: $vm.bio, title: Constants.bio, focusStateField: $isBioField)
            textFieldWithTitle(Constants.enterHere, text: $vm.link, title: Constants.link, focusStateField: .linkField)
        }
    }
    
    private var featurePhotoSection: some View {
        VStack {
            HStack {
                Text(Constants.photos)
                    .font(AppFont.medium.font(size: 13))
                    .foregroundColor(AppColor.blackColor)
                Spacer()
                Text("\(vm.featurePhotos.count)/10")
                    .font(AppFont.medium.font(size: 10))
                    .foregroundColor(AppColor.blackColor)
            }
            if $vm.featurePhotos.isEmpty {
                addPhoto
            } else {
                GeometryReader { geometry in
                    let width = geometry.size.width-20
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: [GridItem(.fixed(140))], spacing: 10) {
                            ForEach(Array(vm.featurePhotos.enumerated()), id: \.offset) { index, picture in
                                
                                ZStack(alignment: .topLeading) {
                                    
                                    Image(uiImage: picture)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: width, height: 140)
                                        .clipped()
                                        .cornerRadius(5)
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(AppColor.borderColor, lineWidth: 1)
                                        }
                                    
                                    if index == 0 {
                                        coverPhotoTextWithView
                                    }
                                    
                                }
                                .frame(width: width, height: 140)
                            }
                            if vm.featurePhotos.count <= 9 {
                                Button(action: {
                                    imagePicker.openPicker(type: .single)
                                }) {
                                    VStack(alignment: .center) {
                                        Image(.addPhotos)
                                    }
                                    .frame(width: width, height: 140)
                                    .cornerRadius(5)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(AppColor.borderColor, lineWidth: 1)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: 140)
            }
        }
        // MARK: - Source Dialog

        .confirmationDialog(
            "Select Source",
            isPresented: $imagePicker.showSourceDialog
        ) {

            Button("Camera") {
                imagePicker.handleSource(.camera)
            }

            Button("Gallery") {
                imagePicker.handleSource(.gallery)
            }
        }

        // MARK: - Gallery Single

        .photosPicker(
            isPresented: Binding(
                get: {
                    imagePicker.showGallery &&
                    imagePicker.selectionType == .single
                },
                set: { imagePicker.showGallery = $0 }
            ),
            selection: $imagePicker.photoItem,
            matching: .images
        )

        // MARK: - Gallery Multiple

        .photosPicker(
            isPresented: Binding(
                get: {
                    imagePicker.showGallery &&
                    imagePicker.selectionType == .multiple
                },
                set: { imagePicker.showGallery = $0 }
            ),
            selection: $imagePicker.photoItems,
            maxSelectionCount: 10,
            matching: .images
        )

        // MARK: - Camera

        .sheet(isPresented: $imagePicker.showCamera) {
            CameraPicker { image in
                imagePicker.setCameraImage(image)
            }
        }

        // MARK: - Load Images

        .onChange(of: imagePicker.photoItem) { _,_ in
            Task {
                await imagePicker.loadSingleImage()
                if let selectedImage = imagePicker.selectedImage {
                    vm.featurePhotos += [selectedImage]
                }
            }
          
        }

        .onChange(of: imagePicker.photoItems) { _,_ in
            Task {
                await imagePicker.loadMultipleImages()
                vm.featurePhotos += imagePicker.selectedImages

            }
        }
    }
    
    private var addPhoto: some View {
        Button(action: {
            imagePicker.openPicker(type: .single)
        }) {
            ZStack {
                VStack{
                    Spacer()
                    Image(.addPhotos)
                    Text(Constants.addPhotos)
                        .font(AppFont.medium.font(size: 13))
                        .foregroundColor(AppColor.blackColor)
                    Spacer()
                }
                coverPhotoTextWithView
                    .frame(height: 140)
            }
            .frame(height: 140)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(AppColor.borderColor, lineWidth: 1)
            }
        }
    }
    
    private var coverPhotoTextWithView: some View {
        VStack {
            Spacer()
            HStack {
                Text(Constants.coverPhoto.capitalized)
                    .font(AppFont.medium.font(size: 10))
                    .foregroundColor(AppColor.whiteColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        AppColor.blackColor.opacity(0.27)
                    )
                    .cornerRadius(4)
                Spacer()
            }
        }
        .padding(6)
    }
    
    private var addressSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.address)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            Button(action: {
                isActiveLocationView = true
            }) {
                HStack {
                    Text(Constants.selectAddress)
                        .font(AppFont.regular.font(size: 13.0))
                        .foregroundStyle(AppColor.blackColor)
                    Spacer()
                    Image(.rightArrow)
                }
                .padding(14)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(AppColor.clearColor)
                        .stroke(AppColor.blackColor, lineWidth: 1)
                }
            }
        }
        .navigationDestination(isPresented: $isActiveLocationView) {
            LocationView(viewTitle: Constants.storeLocation)
        }
    }
    
    private var operatingHoursSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.operatingHours)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            HStack {
                Text(Constants.storeHours)
                    .font(AppFont.regular.font(size: 13.0))
                    .foregroundStyle(AppColor.blackColor)
                Spacer()
                Image(.rightArrow)
            }
            .padding(14)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .fill(AppColor.clearColor)
                    .stroke(AppColor.blackColor, lineWidth: 1)
            }
            .onTapGesture {
                isActiveStoreHoursView = true
            }
        }
        .navigationDestination(isPresented: $isActiveStoreHoursView) {
            StoreHoursView()
        }
    }
    
    private var contactInformationSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(Constants.contactInformation)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            textFieldWithTitle(Constants.enterHere, text: $vm.phone, title: Constants.phoneNumber.capitalized, focusStateField: .phoneField)
            textFieldWithTitle(Constants.enterHere, text: $vm.email, title: Constants.email, focusStateField: .emailField)
        }
    }
    
    private func textFieldWithTitle(_ placeholder: String, text: Binding<String>, title: String, focusStateField: Field, image: Image? = nil, placeholderTextColor: Color? = nil, keyboardType: UIKeyboardType = .namePhonePad) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            HStack {
                image
                TextField(
                    "",
                    text: text,
                    prompt: Text(placeholder)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(placeholderTextColor != nil ? placeholderTextColor! : AppColor.defaultPlaceholderTextColor)
                )
                .keyboardType(keyboardType)
                .textFieldStyle(.plain)
                .focused($focusedField, equals: focusStateField)
                .font(AppFont.regular.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            }
            .padding()
            .background(AppColor.lightGrayColor)
            .cornerRadius(5)
        }
    }
    
    private func textEditorWithTitle(_ placeholder: String, text: Binding<String>, title: String, focusStateField: FocusState<Bool>.Binding) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(AppFont.medium.font(size: 13))
                .foregroundStyle(AppColor.blackColor)
            
                CustomTextEditor(
                    text: text,
                    isFocused: focusStateField,
                    placeholder: Constants.typeHere,
                    cornerRadius: 0,
                    placeholderColor: AppColor.defaultPlaceholderTextColor,
                    textColor: AppColor.blackColor,
                    backgroundColor: AppColor.clearColor,
                    strokeColor: AppColor.clearColor,
                    uiFont: AppFont.regular.uiFont(size: 13),
                    minHeight: 120,
                    maxHeight: 120
                )
                .padding()
                .background(AppColor.lightGrayColor)
                .cornerRadius(5)
            
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            dismiss()
        }) {
            Text(Constants.save)
                .frame(maxWidth: .infinity)
                .padding()
                .font(AppFont.regular.font(size: 15))
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
        }
    }
}

#Preview {
    EditStoreProfileView()
}
