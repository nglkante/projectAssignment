import Foundation

enum RequestError: Error {
    case clientError
    case serverError
    case noDataError
    case decodingError
}

class NetworkService {
    func executeUrlRequest<T: Decodable>(_ request: URLRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, err in
            guard err == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completionHandler(.failure(.serverError))
                return
            }
            guard let data = data else {
                completionHandler(.failure(.noDataError))
                return
            }
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completionHandler(.failure(.decodingError))
                return
            }
            completionHandler(.success(value))
        }
        dataTask.resume()
    }
    
    func fetchCategories(completionHandler: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: "https://v1.mma.api-sports.io/categories") else {
            return completionHandler(.failure(RequestError.serverError))
        }
        var request = URLRequest(url: url)
        request.setValue("6378c9a47aab1f3e72c43fede3a38934", forHTTPHeaderField: "x-rapidapi-key")
        executeUrlRequest(request) { (result: Result<WeightClassesResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                completionHandler(.success(value.response))
            }
        }
    }
    func fetchFighters(weightClass: String, completionHandler: @escaping (Result<[FighterResponse], Error>) -> Void) {
        guard let url = URL(string: "https://v1.mma.api-sports.io/fighters?category=\(weightClass)") else {
            return completionHandler(.failure(RequestError.serverError))
        }
        var request = URLRequest(url: url)
        request.setValue("6378c9a47aab1f3e72c43fede3a38934", forHTTPHeaderField: "x-rapidapi-key")
        executeUrlRequest(request) { (result: Result<FightersResponse, RequestError>) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let value):
                completionHandler(.success(value.response))
            }
        }
    }
}
