//
//  ProfileView.swift
//  CoinMarket
//
//  Created by Phuc Hoang on 10/09/2023.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct ProfileView: View {
    @ObservedObject private var vm = AuthViewModel()
    @ObservedObject private var userManager = UserManager()
    @StateObject private var buyHistoryVM = BuyHistoryViewModel()
    
    @State private var showEditProfile = false
    @Environment(\.colorScheme) var colorScheme
    @State private var language = true
    var email: String? {
        return vm.getEmail()
    }

    
    @State var profileImage: UIImage?
    @State private var isFetchingImage = true
    @State private var profileImageURL: URL?
    @State private var isImagePickerPresented = false
    @State private var isEdited = false
    @State private var toBuyHistory = false
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: UIDevice.isIPhone ? 20 : 50){
                    HStack{
                        Text(language ? "Profile" : "Hồ sơ")
                            .font(.custom("WixMadeForDisplay-ExtraBold", size: UIDevice.isIPhone ? 40 : 50))
                            .foregroundColor(Color.theme.accent)
                            .fontWeight(.bold)
                        Spacer()
                        
                        
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 10))
                    
                    
                    // MARK: ID CARD
                    VStack(alignment: .leading) {
                        //MARK: LOGO
                        HStack(spacing: 0){
                            Spacer()
                            Image("logo-transparent")
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIDevice.isIPhone ? 60 : 150)
                            Text("CoinMarket")
                                .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                                .foregroundColor(.white)
                        }
                        
                        //MARK: INFO
                        if let user = userManager.userInfo {
                            VStack(alignment: .leading, spacing: 10){
                                Text(user.name)
                                    .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                                    .foregroundColor(.white)
                                
                                HStack(spacing: 50){
//                                    VStack(alignment: .leading){
//                                        Text("UserId")
//                                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 16 : 30))
//                                        Text(user.id)
//                                            .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 16   : 30))
//                                    }
                                    
                                    if let userEmail = email {
                                        VStack(alignment: .leading){
                                            Text("Email")
                                                .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 40))
                                            Text(userEmail)
                                                .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 40))
                                        }
                                    }
                                }
                                .foregroundColor(.white)
                            }
                        }
                        else {
                            Text("No user found")
                                .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 40))
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: UIDevice.isIPhone ? 320 : 600)
                    .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 30))
                    .background(.cyan.opacity(0.8))
                    .cornerRadius(20)
                  
                    
                    //MARK: PROFILE IMAGE
                    VStack{
                        if isFetchingImage {
                            ProgressView() // Show a loading indicator while fetching the image
                        } else if let profileImage = profileImage {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 130, height: 130)
                                .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 4)
                                .overlay(
                                    Image(uiImage: profileImage) // Replace with the name of your image asset
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                )
                                .overlay(
                                    Button(action: selectProfilePicture) {
                                        Image("pen") // Replace with the name of your image asset
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 35, height: 35)
                                            .clipShape(Circle())
                                    }
                                        .offset(x: 40, y: 50)
                                )
                        } else {
                            // Display a default placeholder or error image
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(width: UIDevice.isIPhone ? 120 : 180, height: UIDevice.isIPhone ? 120 : 180)
                                .foregroundColor(.gray)
                        }
                        if isEdited {
                            Button("Save", action: {
                                if let profileImage = profileImage, let userId = vm.user?.uid {
                                    saveProfilePicture(profileImage, userID: userId)
                                }
                                isEdited = false
                            })
                        }
                    }
                    
                    // MARK: SETTING
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading){
                            // Row Profile
                            Button(action: {
                                if let user = userManager.userInfo {
                                    print(user.id)
                                }
                                showEditProfile.toggle()
                            }) {
                                HStack(spacing: 20){
                                    Image("profile")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                    Text("Edit profile information")
                                        .modifier(TextModifier())
                                    
                                    Spacer()
                                }
                            }
                            
                            
                            // Row notification
                            Button(action: {
                                print("Edit notification")
                            }) {
                                HStack(spacing: 20){
                                    Image("noti")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                    Text("Notification")
                                        .modifier(TextModifier())
                                    Spacer()
                                }
                            }
                           
                            Button(action: {
                                print("Edit theme")
                                toBuyHistory = true
                            }) {
                                HStack(spacing: 20){
                                    Image(systemName: "purchased")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                    Text("Buy History")
                            // Row Theme
                            Button(action: {
                                print("Edit theme")
                            }) {
                                HStack(spacing: 20){
                                    Image("theme")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                    Text("Theme")
                                        .modifier(TextModifier())
                                    Spacer()
                                }
                            }
                            // Row Theme
                            Button(action: {
                                print("Edit theme")
                            }) {
                                HStack(spacing: 20){
                                    Image("theme")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                    Text("Theme")
                                        .modifier(TextModifier())
                                    Spacer()
                                }
                            }
                            
                            
                            // Row language
                            Button(action: {
                                print("Edit language")
                            }) {
                                HStack(spacing: 20){
                                    Image("lang")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60, height: UIDevice.isIPhone ? 35 : 60)
                                    Text("Language")
                                        .modifier(TextModifier())
                                    
                                    Spacer()
                                    
                                    Image(language ? "uk" : "vietnamese")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: UIDevice.isIPhone ? 35 : 60)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: UIDevice.isIPhone ? 320 : 600)
                    .padding(EdgeInsets(top: 30, leading: 25, bottom: 30, trailing: 25))
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 20) // Rounded border
                            .stroke(Color.gray, lineWidth: 0.1) // Border color and width
                            .background(
                                RoundedRectangle(cornerRadius: 20) // Rounded border background
                                    .fill(Color.white) // Border background color
                                    .shadow(color: Color.gray, radius: 5, x: 0, y: 2) // Shadow for the border
                            )
                    )
                    
                    
                    Spacer()
                    Button {
                        vm.signOut()
                    } label: {
                        Text("Sign out")
                            .modifier(SignOutButton())
                        
                    }
                    .frame(maxWidth: 320)
                    Spacer()
                }
            }
            
        }
        .sheet(isPresented:$showEditProfile) {
            EditNameView()
        }
        .onChange(of: showEditProfile){newValue in
            userManager.getUserInfo {
                print("get")
            }
        }
            
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $profileImage)
        }
        .sheet(isPresented: $showEditProfile){
            EditProfileView(dismiss: dismiss)
        }
        .fullScreenCover(isPresented: $toBuyHistory, content: {
            BuyHistoryView()
                .environmentObject(buyHistoryVM)
        })
        .onAppear {
            print("On Appear profile view")
            if let userId = vm.user?.uid {
                fetchProfileImage(userID: userId)
            }
        }
    }
    
    //MARK: FUNCTIONS
    private func fetchProfileImage(userID: String) {
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profileImages/\(userID).jpg")
        
        profileImageRef.getData(maxSize: Int64(5 * 1024 * 1024)) { data, error in
            if let error = error {
                print("Error fetching profile image: \(error.localizedDescription)")
                isFetchingImage = false
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                profileImage = image
                isFetchingImage = false
            }
        }
    }
    
    func selectProfilePicture() {
        isEdited = true
        isImagePickerPresented = true
    }
    
    func saveProfilePicture(_ image: UIImage, userID: String) {
        let storageRef = Storage.storage().reference()
        let profileImageRef = storageRef.child("profileImages/\(userID).jpg")
        
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            profileImageRef.putData(imageData, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error uploading profile picture: \(error.localizedDescription)")
                } else {
                    // Successfully uploaded profile picture
                    profileImageRef.downloadURL { (url, error) in
                        if let url = url {
                            // You can save the download URL to the user's Firestore document or wherever you store user data.
                            // For example, you can update the user's document with the download URL.
                            self.updateUserProfilePictureURL(url, userID: userID)
                        }
                    }
                }
            }
        }
    }
    
    func updateUserProfilePictureURL(_ url: URL, userID: String) {
        // You can update the user's Firestore document with the profile picture URL.
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(userID)
        
        userRef.updateData(["profilePictureURL": url.absoluteString]) { (error) in
            if let error = error {
                print("Error updating profile picture URL: \(error.localizedDescription)")
            } else {
                print("Profile picture URL updated successfully")
            }
        }
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
