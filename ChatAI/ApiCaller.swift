//
//  ApiCaller.swift
//  ChatAI
//
//  Created by Comcom on 2023/07/21.
//
import OpenAISwift
import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    @frozen enum Constants {
        static let key = "APIKEY"
    }
    
    private var client: OpenAISwift?
    
    private init() {}
    
    public func setup() {
        self.client = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: Constants.key))
    }
    
    public func getResponse(input: String, completion: @escaping (Result<String, Error>) -> Void) {
        client?.sendCompletion(with: input, completionHandler: { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
                let output = model.choices?.first?.text ?? ""
                completion(.success(output))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
