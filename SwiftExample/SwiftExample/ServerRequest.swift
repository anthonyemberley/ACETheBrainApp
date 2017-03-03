//
//  ServerRequest.swift
//  
//
//  Created by Anthony Emberley on 11/25/16.
//
//

import UIKit
import SwiftyJSON
import Alamofire

class ServerRequest: NSObject {
    private let useDevServer = true
    private let baseURL = "https://ace-the-brain-api-pro.herokuapp.com/api/"
    private let stagingURL = "https://ace-the-brain-api-stage.herokuapp.com/api/"
    private let devURL = "http://127.0.0.1:5000/api/"
    private let kUserRequestKey = "user"
    static let shared = ServerRequest();
    
    //MARK :  Helper Methods
    private func getWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = useDevServer ? devURL : baseURL
        let path : String = url + endpoint;
        
        
        Alamofire.request(path, method: .get, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            let status = response.response?.statusCode
            if let data = response.data {
                let json = JSON(data:data)
                if(status == 200 || status == 201) {
                    success(json)
                } else {
                    failure(json)
                }
            }
        }
    }
//    
//    private func updateWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:(json:JSON) -> Void, failure:(error:JSON) -> Void) {
//        let url = useStagingServer ? stagingURL : baseURL
//        let path : String = url + endpoint
//        let headers = getRequestHeaders(authenticated)
//        Alamofire.request(.PUT, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { response in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200 || status == 201) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
//    }
    
    private func postWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ error:JSON) -> Void) {
        let url = useDevServer ? devURL : baseURL
        let path : String = url + endpoint
        
        Alamofire.request(path, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            let status = response.response?.statusCode
            if let data = response.data {
                
                let json = JSON(data:data)
                if(status == 200 || status == 201) {
                    success(json)
                } else {
                    failure(json)
                }
            }
        }
    }
    
//    private func stagedPostWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:(json:JSON,completed:Bool) -> Void, failure:(error:JSON) -> Void) {
//        let url = useStagingServer ? stagingURL : baseURL
//        let path : String = url + endpoint
//        let headers = getRequestHeaders(authenticated)
//        Alamofire.request(.POST, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { (response) -> Void in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200 || status == 201) {
//                    success(json: json, completed: (status == 200))
//                } else {
//                    failure(error: json)
//                }
//            }
//            
//            
//        }
//    }
//    
//    private func putWithEndpoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:(json:JSON) -> Void, failure:(error:JSON) -> Void) {
//        let url = useStagingServer ? stagingURL : baseURL
//        let path : String = url + endpoint
//        let headers = getRequestHeaders(authenticated)
//        Alamofire.request(.PUT, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { response in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200 || status == 201) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
//    }
//    
//    private func deleteWithEndoint(endpoint:String, parameters:[String : AnyObject]?, authenticated:Bool, success:(json:JSON) -> Void, failure:(error:JSON) -> Void) {
//        let url = useStagingServer ? stagingURL : baseURL
//        let path : String = url + endpoint
//        let headers = getRequestHeaders(authenticated)
//        Alamofire.request(.DELETE, path, parameters: parameters, headers:headers, encoding: .JSON).responseJSON { (response) -> Void in
//            let status = response.response?.statusCode
//            if let data = response.data {
//                let json = JSON(data:data)
//                if(status == 200 || status == 201) {
//                    success(json: json)
//                } else {
//                    failure(error: json)
//                }
//            }
//        }
//    }
    
    //MARK: UserAuthentication
//    func signUpWithPayload(payload:NSDictionary, success:(json:JSON) -> Void, failure:(errorMessage:String) -> Void) {
//        let parameters = [kUserRequestKey : payload]
//        
//        postWithEndpoint("signup", parameters: parameters, authenticated: false,
//                         success: { (json) -> Void in
//                            self.updateAuthenticationToken(json["authentication_token"].string)
//                            
//                            success(json: json)
//            }, failure: { (errorJson) -> Void in
//                let errors = errorJson["errors"][0]
//                if let reasons = errors["email"].array {
//                    let errorMessage = "Email "+(reasons[0].string)!
//                    failure(errorMessage: errorMessage)
//                }
//        })
//    }
    
    func testServerRequest() {
        
        getWithEndpoint(endpoint: "", parameters: nil, authenticated: true, success: { (json) -> Void in
            print(json)
            },failure: { (json) -> Void in
            print(json)
        })
        
    }
    
    
    func newTextResponse() {
        
        getWithEndpoint(endpoint: "", parameters: nil, authenticated: true, success: { (json) -> Void in
            print(json)
        },failure: { (json) -> Void in
            print(json)
        })
        
    }
    
    
    func signUpWithEmail(email:String, password:String, username:String, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ errorMessage:String) -> Void) {
        let parameters = ["email":email, "password":password, "username":username]
        postWithEndpoint(endpoint: "CreateUser", parameters: parameters as [String : AnyObject]?, authenticated: false, success: { (json) -> Void in
                success(json)
        }, failure: { (errorJson) -> Void in
                let errors = errorJson["errors"][0]
                if let reasons = errors["email"].array {
                    let errorMessage = "Email "+(reasons[0].string)!
                    failure(errorMessage)
                }
        })
    }
    

    func loginWithEmail(email:String, password:String, success:@escaping (_ currentUser:UserAPI) -> Void, failure:@escaping (_ errorMessage:String) -> Void) {
        let parameters = ["email":email, "password":password]
        postWithEndpoint(endpoint: "LoginUser", parameters: parameters as [String : AnyObject]?, authenticated: false, success: { (json) -> Void in
            let result:UserAPI =  UserAPI(fromJson:json)
            success(result)
            }, failure: { (error) -> Void in
                failure("Invalid Email and Password")
        })
    }
    
    func sendNewQuestionResponse(user_id:Int, question:String, response:String, response_time:Int, errors:Int, pauses:Int, success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ errorMessage:String) -> Void) {
        let parameters = ["user_id": user_id, "question": question, "response": response, "response_time": response_time, "errors": errors, "pauses": pauses] as [String : Any]
        postWithEndpoint(endpoint: "NewResponse", parameters: parameters as [String : AnyObject]?, authenticated: false, success: { (json) -> Void in
            success(json)
        }, failure: { (errorJson) -> Void in
            failure(errorJson.stringValue)
            
        })
    }
    
    func postNewQuestion(questions_asked:[String], success:@escaping (_ json:JSON) -> Void, failure:@escaping (_ errorJSON:JSON) -> Void) {
        let parameters = ["questions_asked": questions_asked]
        postWithEndpoint(endpoint: "NewQuestion", parameters: parameters as [String : AnyObject]?, authenticated: false, success: { (json) -> Void in
            success(json)
        }, failure: { (errorJson) -> Void in
            failure(errorJson)
            
        })
    }
    
    
    
//    //TODO Returns error of invalid email and password?
//    func logout(success:(json:JSON) -> Void, failure:(errorMessage:String) -> Void){
//        postWithEndpoint("logout", parameters: nil, authenticated: true, success: { (json) -> Void in
//            
//            UserCredentials.shared.deleteUserToken()
//            success(json: json)
//            }, failure: { (error) -> Void in
//                
//                failure(errorMessage: "Unable to logout")
//        })
//        
//        
//    }
//    
//    //MARK: User
//    func getCurrentUser(completion:(currentUser:User) -> Void) {
//        let endpoint = "current_user"
//        
//        getWithEndpoint(endpoint, parameters: nil, authenticated: true, success: { (json) -> Void in
//            let result:User =  User(fromJson:json)
//            completion(currentUser: result)
//            },failure: { (error) -> Void in
//                
//        })
//    }
    
}
    
