//
//  AddMeal.swift
//  food-tracker-ai
//
//  Created by Ethan Shafran Moltz on 11/22/23.
//

import SwiftUI
import SwiftData

struct AddMeal: View {
    
    @State private var image: UIImage?
    @State private var showCamera = false
    
    var body: some View {
        VStack {
            Image(uiImage: image ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
            Button("Take Photo") {
                
                
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(15)
            
            
        }
        .sheet(isPresented: $showCamera){
            CameraView()
        }
    }
   
}
struct CameraView: UIViewControllerRepresentable {

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

#Preview {
    AddMeal()
}
