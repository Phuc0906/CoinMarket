import SwiftUI
import Firebase

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""
    @State private var imagePickerCoordinator: ImagePickerCoordinator?
    
    // MARK: need name and balance text field
    @State private var name = ""
    @State private var balance = "0"
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var nextView: Bool = false
    @State var LoginView: Bool = false
    
    @State private var language = true //true = English, false  = Vietnamese
    @State private var theme = true // true = light, false = dark
    
    var body: some View {
        
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            GeometryReader{ geometry in
                HStack{
                    Spacer()
                    // language button
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
                    
                    // theme button
                    Button(action: {
                        // Add your action here
                        print("Change mode")
                        language.toggle()
                    }) {
                        Image(systemName: theme ? "moon.fill" : "sun.max.fill")
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
        
        .fullScreenCover(isPresented: $nextView) {
            MainView()
        }
        
        .fullScreenCover(isPresented: $LoginView) {
            CoinMarket.LoginView()
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
