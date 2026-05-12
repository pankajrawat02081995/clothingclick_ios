//
//  SellAddDetailsView.swift
//  clothingclick
//
//  Created by DavidBisht on 09/05/26.
//

import SwiftUI
import PhotosUI

struct SellAddDetailsView: View {
    
    let styles: [String] = ["Streetwear","Athletic","Designer","Formal","Vintage","Casual"]
    @State var department: String
    @State var category: String
    @State var subcategory: String
    @State var size: String
    @State var condition: String
    @State var colors: [String]
    @State private var selectedStyle: String? = nil
    @StateObject private var vm = SellAddDetailsViewModel()
    @FocusState private var focusedField: Field?
    @StateObject private var imagePicker = ImagePickerManager()
    @FocusState private var isDescriptionFocusState: Bool
    @State private var isActiveSearchBrandsAndDesignersView: Bool = false
    @State private var isActivePhotoGuideView: Bool = false
    @State private var isActiveLocationView: Bool = false
    @State private var isActiveProductPreviewView: Bool = false

    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { ScrollViewProxy in
                    ScrollView {
                        VStack(spacing: 20){
                            styleSection
                            detailsSection
                        }
                        .padding()
                    }
                }
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                bottomSection
            }
            .onAppear() {
                vm.department = department
                vm.category = category
                vm.subcategory = subcategory
                vm.size = size
                vm.condition = condition
                vm.colors = colors
            }
            .alert(Constants.AppName, isPresented: $vm.showError) {
                Button(Constants.ok, role: .cancel) { }
                  } message: {
                      Text(vm.error ?? "")
                  }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.sell,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        dismiss()
                    }
                ),
                
                trailing: [NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 10, relativeTo: .title),
                    image: "cross",
                    isSystemImage: false,
                    action: {
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    private var styleSection: some View {
        VStack(alignment: .leading) {
            Text(Constants.style)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(styles, id: \.self) { item in
                    let isSelected : Bool = selectedStyle == item
                    Button {
                        selectedStyle = item
                        vm.style = selectedStyle ?? ""
                    } label: {
                        VStack {
                            Text(item)
                                .font(AppFont.regular.font(size: 13))
                                .foregroundStyle(isSelected ? AppColor.whiteColor : AppColor.blackColor)
                        }
                        .padding(14)
                        .frame(maxWidth: .infinity)
                        .background(isSelected ? AppColor.blackColor : AppColor.clearColor)
                        .cornerRadius(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(AppColor.clearColor)
                                .stroke(isSelected ? AppColor.blackColor : AppColor.borderColor, lineWidth: 1)
                        }
                    }
                }
            }
        }
    }
    
    private var detailsSection: some View {
        VStack(alignment: .leading,spacing: 10) {
            Text(Constants.details)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
            
            textFieldWithTitle(Constants.searchDesignersAndBrandNames, text: $vm.brandName, title: Constants.brandName, focusStateField: .brandNameField, image: Image("search"), placeholderTextColor: AppColor.blackColor)
                .disabled(true)
                .onTapGesture {
                    isActiveSearchBrandsAndDesignersView = true
                }
            
            textFieldWithTitle(Constants.enterHere, text: $vm.productTitle, title: Constants.title, focusStateField: .titleField)
            
            photosSection
            
            textEditorWithTitle(Constants.enterHere, text: $vm.productDescription, title: Constants.description, focusStateField: $isDescriptionFocusState)
            
            textFieldWithTitle("0", text: $vm.productPrice, title: Constants.price, focusStateField: .priceField, keyboardType: .numberPad)
            
            textFieldWithTitle(Constants.enterHere, text: $vm.sellLocation, title: Constants.location, focusStateField: .locationField)
                .disabled(true)
                .onTapGesture {
                    isActiveLocationView = true
                }
        }
        .navigationDestination(isPresented: $isActiveLocationView) {
            LocationView { location in
                isActiveLocationView = false
                if location.isEmpty == false {
                    vm.sellLocation = location
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                
                // Show only for description and price field
                if isDescriptionFocusState == true || focusedField == .priceField {
                    Spacer()
                    
                    Button(Constants.done) {
                        focusedField = nil
                        isDescriptionFocusState = false
                    }
                }
            }
        }
    }
    
    private var photosSection: some View {
        VStack {
            HStack {
                Text(Constants.photos)
                    .font(AppFont.medium.font(size: 13))
                    .foregroundColor(AppColor.blackColor)
                Spacer()
                HStack(spacing: 2) {
                    Image(.info)
                    Text(Constants.guide)
                        .font(AppFont.medium.font(size: 10))
                        .foregroundColor(AppColor.blackColor)
                }
                .onTapGesture {
                    isActivePhotoGuideView = true
                }
            }
            if $vm.productPhotos.isEmpty {
                addPhoto
            } else {
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                    ForEach(Array(vm.productPhotos.enumerated()), id: \.offset) { index, picture in
                        
                        ZStack(alignment: .topLeading) {
                            
                            Image(uiImage: picture)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 105, height: 105)
                                .clipped()
                                .cornerRadius(5)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(AppColor.borderColor, lineWidth: 1)
                                }

                            HStack {
                                
                                if index == 0 {
                                    Text(Constants.cover)
                                        .font(AppFont.medium.font(size: 10))
                                        .foregroundColor(AppColor.whiteColor)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(
                                            AppColor.blackColor.opacity(0.27)
                                        )
                                        .cornerRadius(4)
                                }

                                Spacer()

                                Image(.deletePhoto)
                                    .padding(6)
                            }
                            .padding(6)
                        }
                        .frame(width: 105, height: 105)
                    }
                    VStack(alignment: .center) {
                        Image(.addPhotos)
                    }
                    .frame(width: 105, height: 105)
                    .cornerRadius(5)
                    .overlay {
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(AppColor.borderColor, lineWidth: 1)
                    }
                    .onTapGesture {
                        imagePicker.openPicker(type: .single)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isActiveSearchBrandsAndDesignersView , destination: {
            SearchBrandsAndDesignersView { selectedItem in
                isActiveSearchBrandsAndDesignersView = false
                if selectedItem.isEmpty == false {
                    vm.brandName = selectedItem
                    vm.productTitle = selectedItem
                }
            }
        })
        .navigationDestination(isPresented: $isActivePhotoGuideView , destination: {
            PhotoGuideView()
        })
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
                    vm.productPhotos += [selectedImage]
                }
            }
          
        }

        .onChange(of: imagePicker.photoItems) { _,_ in
            Task {
                await imagePicker.loadMultipleImages()
                vm.productPhotos += imagePicker.selectedImages

            }
        }
    }
    
    private var addPhoto: some View {
        VStack{
            Spacer()
            Image(.addPhotos)
            Text(Constants.addPhotos)
                .font(AppFont.medium.font(size: 13))
                .foregroundColor(AppColor.blackColor)
            Spacer()
        }
        .frame(height: 140)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(AppColor.borderColor, lineWidth: 1)
        }
        .onTapGesture {
            imagePicker.openPicker(type: .single)
        }
    }
    
    private var bottomSection: some View {
        
        HStack {
            Button(action: {
                isActiveProductPreviewView = true
            }) {
                Text(Constants.preview)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColor.clearColor)
                    .font(AppFont.medium.font(size: 15.0))
                    .foregroundColor(AppColor.blackColor)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(AppColor.clearColor)
                            .stroke(AppColor.blackColor, lineWidth: 1)
                    )
            }
            Button(action: {
                if vm.validate() == false {
                    vm.showError = true
                }
            }) {
                Text(Constants.post)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColor.blackColor)
                    .font(AppFont.medium.font(size: 15.0))
                    .foregroundColor(AppColor.whiteColor)
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(AppColor.clearColor)
                            .stroke(AppColor.blackColor, lineWidth: 1)
                    )
            }
        }
        .padding()
        .navigationDestination(isPresented: $isActiveProductPreviewView , destination: {
            ProductPreviewView(product: vm.fetchProductDetails())
        })
        
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
    
}

//#Preview {
//    SellAddDetailsView()
//}
