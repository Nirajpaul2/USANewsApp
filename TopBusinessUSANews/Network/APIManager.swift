//
//  JsonFileReader.swift
//  TopBusinessUSANews
//
//  Created by niraj paul on 05/01/25.
//

import Foundation

enum DemoError: Error {
    case badPath
    case noData
    case decodingFailed
}

enum HTTPSMethod: String {
    case get = "GET"
    case post = "POST"
}

// Protocol for reading JSON files
protocol APIManagerProtocol {
    func getData<T: Decodable>(url: String, httpsMethod: HTTPSMethod) async throws -> T
}

// Implementation of the JSON file reader
final class APIManager: APIManagerProtocol {
    let httpsClient: HTTPSClientProtocol?
    let dataDecoder: JsonDecoderProtocol?
    
    init(httpsClient: HTTPSClientProtocol = HTTPSClient(), dataDecoder: JsonDecoderProtocol = JsonDecoder()) {
        self.httpsClient = httpsClient
        self.dataDecoder = dataDecoder
    }
    
    func getData<T: Decodable>(url: String, httpsMethod: HTTPSMethod) async throws -> T {
        do {
            // Fetch raw data asynchronously
            guard let data = try await httpsClient?.fetchData(from: url, method: httpsMethod) else { throw DemoError.noData }
            
            // Decode the data into the specified type
            guard let decodedData = try await dataDecoder?.decodeData(type: T.self, data: data) else { throw DemoError.decodingFailed }
            return decodedData
        } catch {
            throw DemoError.decodingFailed
        }
    }
}

// Protocol for file reading
protocol HTTPSClientProtocol {
    func fetchData(from urlString: String, method: HTTPSMethod) async throws -> Data
}

// Implementation of the file reader
class HTTPSClient: HTTPSClientProtocol {
    func fetchData(from urlString: String, method: HTTPSMethod) async throws -> Data {
           // Validate URL
           guard let url = URL(string: urlString) else {
               throw DemoError.badPath
           }
           
           // Create URL request
           var urlRequest = URLRequest(url: url)
           urlRequest.httpMethod = method.rawValue
           
           do {
               // Fetch data using async URLSession
               let (data, response) = try await URLSession.shared.data(for: urlRequest)
               
               // Validate HTTP response
               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                   throw DemoError.noData
               }
               
               return data
           } catch {
               throw DemoError.noData
           }
       }
    
}

// Protocol for JSON decoding
protocol JsonDecoderProtocol {
    func decodeData<T: Decodable>(type: T.Type, data: Data) async throws -> T
}

// Implementation of the JSON decoder
class JsonDecoder: JsonDecoderProtocol {
    func decodeData<T: Decodable>(type: T.Type, data: Data) async throws -> T {
        let decoder = JSONDecoder()
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(inputDateFormatter)
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }
}
