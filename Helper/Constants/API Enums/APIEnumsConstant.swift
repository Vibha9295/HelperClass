//
//  APIEnumsConstant.swift
//  GoodNews
//

//MARK: - Http Method
enum HttpMethod : String {
    
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

//MARK: - HTTP Header Fields
enum HTTPHeaderFields : String {
    
    case application_json = "application/json"
    case application_x_www_form_urlencoded = "application/x-www-form-urlencoded"
    case constStatementsPDFValueField = "application/pdf"
}
