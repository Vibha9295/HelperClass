//
//  ApiCall.swift
//

class ApiCall {
    
    static let shared : ApiCall = ApiCall()
    
    let constHeaderField = "Content-Type"
    
    func post<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: HttpMethod.post.rawValue, model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func put<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl:apiUrl, params: requestPARAMS as [String : AnyObject], method: HttpMethod.put.rawValue, model: model, isLoader : isLoader, isErrorToast : isErrorToast, completion: completion)
    }
    
    func get<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestGetMethod(apiUrl: apiUrl, method: HttpMethod.get.rawValue, model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func delete<T : Decodable>(apiUrl : String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestDeleteMethod(apiUrl: apiUrl, method: HttpMethod.delete.rawValue, model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func patch<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestPatchMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: HttpMethod.patch.rawValue, model: model, isLoader : isLoader, isErrorToast : isErrorToast, isAPIToken : isAPIToken, completion: completion)
    }
    
    func requestMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: String, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method
        request.setValue(HTTPHeaderFields.application_json.rawValue, forHTTPHeaderField: constHeaderField)
        
        if isAPIToken, let strToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.addValue("Bearer " + strToken, forHTTPHeaderField: "Authorization")
        }
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModel.self, from: data)
                let status = dictResponse.status ?? ""
                
                if status == "ok" {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestGetMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method
        request.addValue(HTTPHeaderFields.application_json.rawValue, forHTTPHeaderField: constHeaderField)
        
        if isAPIToken, let strToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.addValue("Bearer " + strToken, forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModel.self, from: data)
                let status = dictResponse.status ?? ""
                
                if status == "ok" {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestDeleteMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method
        request.addValue(HTTPHeaderFields.application_json.rawValue, forHTTPHeaderField: constHeaderField)
        
        if isAPIToken, let strToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.addValue("Bearer " + strToken, forHTTPHeaderField: "Authorization")
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModel.self, from: data)
                let status = dictResponse.status ?? ""
                
                if status == "ok" {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestPatchMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: String, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true, isAPIToken : Bool = false, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        if isLoader {
            Utility().showLoader()
        }
        
        var request = URLRequest(url: URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!)
        request.httpMethod = method
        request.setValue(HTTPHeaderFields.application_json.rawValue, forHTTPHeaderField: constHeaderField)
        
        if isAPIToken, let strToken : String = KeychainWrapper.standard.string(forKey: UserDefault.kAPIToken) {
            request.addValue("Bearer " + strToken, forHTTPHeaderField: "Authorization")
        }
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            Utility().hideLoader()
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModel.self, from: data)
                let status = dictResponse.status ?? ""
                
                if status == "ok" {
                    let dictResponsee = try decoder.decode(model, from: data)
                    mainThread {
                        completion(true, dictResponsee as AnyObject)
                    }
                } else {
                    mainThread {
                        completion(false, dictResponse.message as AnyObject)
                    }
                }
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8) {
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
}

//MARK: - Model Class
class GeneralResponseModel : Codable {
    let status : String?
    let totalResults : Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case totalResults = "totalResults"
        case message = "message"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
