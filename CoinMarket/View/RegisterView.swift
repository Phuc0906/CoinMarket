import SwiftUI
import Firebase
import FirebaseStorage


struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var imagePickerCoordinator: ImagePickerCoordinator?
    
    // MARK: need name and balance text field
    @State private var name = ""
    @State private var balance = "0"
    @State var profileImage: UIImage?
    @State private var isImagePickerPresented = false


    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nextView: Bool = false
    @State var LoginView: Bool = false
    
    @State private var language = false
    
    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            GeometryReader{ geometry in
                HStack{
                    Spacer()
                    Button(action: {
                        // Add your action here
                        print("Change language")
                        language.toggle()
                    }) {
                        Image(language ? "uk" : "vietnam")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIDevice.isIPhone ? 40 : 50)
                    }
                }
                .padding(.horizontal, 10)
                
                VStack (alignment: .leading, spacing: 20){
                    HStack{
                        Image("logo-transparent")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIDevice.isIPhone ? 100 : 150)
                        Text("CoinMarket")
                            .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                    }
                    
                    Text(language ? "Let's start your journey" : "Bắt đầu ngay bây giờ")
                        .font(.custom("WixMadeforDisplay-ExtraBold", size: UIDevice.isIPhone ? 25 : 40))
                        .padding(.vertical)
                    
                    VStack{
                        if let profileImage = profileImage {
                            Image(uiImage: profileImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                        Button(action: selectProfilePicture) {
                            Text("Select Profile Picture")
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(language ? "Username" : "Tên người dùng")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        TextField(language ? "Username" : "Tên người dùng", text: $name)
                            .modifier(TextFieldModifier())
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text("Email")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .modifier(TextFieldModifier())
                    }
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(language ? "Password" : "Mật khẩu")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField(language ? "Password" : "Mật khẩu", text: $password)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                    
                    VStack(alignment: .leading, spacing: 5){
                        Text(language ? "Confirm Password" : "Xác nhận mật khẩu")
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 20 : 30))
                        SecureField(language ? "Confirm Password" : "Xác nhận mật khẩu", text: $confirmPassword)
                            .modifier(TextFieldModifier())
                    }
                    
                    
                    if !errorMessage.isEmpty{
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 16 : 25))
                    }
                    
                    Button(action: register) {
                        Text(language ? "Register" : "Đăng kí")
                            .modifier(LongButton())
                    }
                    
                    VStack{
                        Button(action: {
                            LoginView = true
                        }) {
                            Text(language ? "Already have an account?" : "Bạn có tài khoản rồi?")
                                .font(.custom("WixMadeforDisplay-Medium", size: UIDevice.isIPhone ? 20 : 30))
                        }
                        
                        // MARK: - BUTTON START
                        Button(action: {
                            nextView = true
                        }) {
                            HStack {
                                Text(language ? "Get start" : "Bắt đầu")
                                    .font(.custom("WixMadeforDisplay-Bold", size: UIDevice.isIPhone ? 25 : 35))
                                Image(systemName: "arrow.right")
                                    .foregroundColor(.black)
                            }.padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(.yellow)
                                .cornerRadius(30)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .frame(width: UIDevice.isIPhone ? geometry.size.width * 0.8 : geometry.size.width * 0.6)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.5)
            }
            
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $profileImage)
        }

        .fullScreenCover(isPresented: $nextView) {
            MainView()
        }
        
        .fullScreenCover(isPresented: $LoginView) {
            CoinMarket.LoginView()
        }
        
    }
    
    func selectProfilePicture() {
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

    

    
    func register() {
        if password == confirmPassword {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    if let user = authResult?.user {
                        let userID = user.uid

                        print("User ID: \(userID)")

                        // Save the profile picture and user data
                        if let profileImage = profileImage {
                            saveProfilePicture(profileImage, userID: userID)
                        }

                        let newUser = UserInfo(id: userID, name: name, balance: balance)
                        saveUserData(user: newUser)

                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        } else {
            errorMessage = language ? "Passwords do not match." : "Mật khẩu không đúng."
        }
    }

    
    func saveUserData(user: UserInfo) {
        let db = Firestore.firestore()
        
        do {
            let encodedData = try JSONEncoder().encode(user)
            let jsonString = String(data: encodedData,
                                    encoding: .utf8)
            db.collection("users").document("\(user.id)").setData(["profile": jsonString!])
        }catch{
            print("error")
        }
        
        
    }
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        RegisterView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        RegisterView()
            .previewDevice(PreviewDevice(rawValue: "iPad Pro (12.9-inch)"))
            .previewDisplayName("iPad Pro")
    }
}
