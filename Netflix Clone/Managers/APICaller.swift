//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Jos Nguyen on 24/10/2023.
//

import Foundation

struct Constants {
    static let API_KEY = "5b89ef878cd931e5e8487faf8c931cd8"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    func getTredingMovies(completion :@escaping (Result<[Title], Error>) -> Void) {
        let urlString = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)"
        guard let url = URL(string:urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                NSLog(" get trendig moviese Success: \(result)")
                completion(.success(result.results))
            } catch{
                NSLog(" get trendig moviese faild: \(error)")
                completion(.failure(APIError.failedTogetData))
            }
        }
        return task.resume()
    }
    
    func getTrendingTvs(completion :@escaping(Result<[Title],Error>)-> Void){
        let urlString = "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)"
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
        
            guard let data = data, error == nil else {
                return
            }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                NSLog("trending Tvs:\(result)")
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
                NSLog(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping(Result<[Title],Error>)-> Void){
        let urlString = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data,_,error in
            guard let data = data,error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(result)
                completion(.success(result.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping(Result<[Title],Error>)-> Void){
        let urlString = "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data,_,error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(result)
                completion(.success(result.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getTopRateMovies(completion: @escaping(Result<[Title],Error>)-> Void){
        let urlString = "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){ data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                print(result)
                completion(.success(result.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping(Result<[Title],Error>)-> Void){
        let urlString = "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc"
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func search (with query : String, completion : @escaping(Result<[Title],Error>)-> Void){
        let urlString = "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)"
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else{ return}
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data ,error == nil else {
                return
            }
            
            do{
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            } catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
}
 
