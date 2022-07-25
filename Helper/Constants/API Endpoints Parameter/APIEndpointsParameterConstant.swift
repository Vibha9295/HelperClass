//
//  APIEndpointsParameterConstants.swift
//  GoodNews
//

//MARK: - Web Service URLs
enum WebServiceURL {
    
    static let mainURL = "https://newsapi.org/v2/"
    
    static let topHeadlinesURL = mainURL + "top-headlines?"
}

//MARK: - Web Service Parameters
enum WebServiceParameter {
    
    static let pCountry = "country"
    static let pAPIKey = "apiKey"
}

