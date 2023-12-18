import Foundation
import OpenAIKit
import SwiftDotenv

func gptExecute(){
    
    var apiKey: String {
        ProcessInfo.processInfo.environment["OPENAI"]!
    }
    print("API key: ", apiKey)
//    
//    var model=Model.GPT4.gpt40314
//
//    
    
    
    
}


