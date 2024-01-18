//
//  ImageManager.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import Foundation

final class ImageManager {
    static let shared = ImageManager()
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    private init() {}
    
    /// This method either downloads or retrieves image by provided URL via URLSession data task and stores/retrieves the result in/from the private cache of the singleton class
    /// - Parameters:
    ///   - url: Image URL
    ///   - completion: completion handler in a Result wrapper
    func downloadImage(_ url: URL, completion: @escaping (Result<Data,Error>) -> Void) {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self?.imageDataCache.setObject(value, forKey: key)
            completion(.success(data))
        }
        task.resume()
    }
    
    
}

