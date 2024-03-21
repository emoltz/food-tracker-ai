import SwiftUI
import SwiftData

struct AddMeal: View {
    
    @State private var image: UIImage?
    @State private var showCamera = false
    @State private var isPressed = false
    
    var body: some View {
        VStack {
            if let img = image {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            else{
                ZStack {
                    Rectangle()
                        .fill(.tertiary)
                    Image(systemName: "camera")
                        .font(.system(size: 64))
                        .foregroundStyle(.secondary)
                }
                .cornerRadius(20)
                .padding()
                .onTapGesture{
                    isPressed = true
                    showCamera = true
                }
                
                
            }
            
            
            
            Button("Describe",systemImage: "mic.circle", action: {
                
                
            } )
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(15)
                
            
        }
        .sheet(isPresented: $showCamera){
            CameraView(image: $image)
        }
    }
    
}
struct CameraView: UIViewControllerRepresentable {
    /*
     CameraView creates and manages a UIKit component (UIImagePickerController) within a SwiftUI context, handling user interactions and state updates in a manner akin to combining React components with traditional JavaScript event handling and state management in a full stack web application.
     
     */
    @Environment(\.presentationMode) var presentationMode
    @Binding var image: UIImage?
    
    func makeCoordinator() -> Coordinator {
        /*
         This method creates an instance of Coordinator, which is a helper class that manages the interaction between the UIImagePickerController (the component that handles taking photos or selecting images) and your SwiftUI view. It's somewhat akin to creating a controller or service in a web app to handle logic and communication between components.
         */
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    
}

#Preview {
    AddMeal()
}
