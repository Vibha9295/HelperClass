//
//  AlertMessageConstant.swift
//  GoodNews
//

//MARK: - Alert Message's
enum AlertMessage {
    
    //In Progress Message
    static let msgComingSoon = "Coming soon"
    
    //Internet Connection Message
    static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"
    
    //Camera, Images and ALbums Related Messages
    static let msgPhotoLibraryPermission = "Please enable access for photos from Privacy Settings"
    static let msgCameraPermission = "Please enable camera access from Privacy Settings"
    static let msgNoCamera = "Device has no camera"
    static let msgImageSaveIssue = "Photo is unable to save in your local storage. Please check storage or try after some time"
    static let msgSelectPhoto = "Please select photo"
    static let msgNotFoundBackCamera = "Could not find a back camera"
    static let msgNotCreateVideoDevice = "Could not create video device input"
    static let msgNotAddVideoInputSession = "Could not add video device input to the session"
    static let msgNotAdVideoOutputSession = "Could not add video data output to the session"
    
    //General Error Message
    static let msgError = "Something went wrong. Please try after sometime"
    
    //Validation Messages
    static let msgFirstName = "Please enter first name"
    static let msgValidFirstName = "First name must contain atleast 2 characters and maximum 30 characters"
    
    static let msgLastName = "Please enter last name"
    static let msgValidLastName = "Last name must contain atleast 2 characters and maximum 30 characters"
    
    static let msgFullName = "Please enter full name"
    static let msgValidFullName = "Full name must contain atleast 2 characters and maximum 60 characters"
    
    static let msgEmail = "Please enter email address"
    static let msgValidEmail = "Please enter valid email address"
    
    static let msgGender = "Please select gender"
    
    static let msgDOB = "Please enter date or birth"
    
    static let msgPincode = "Please enter pincode"
    static let msgState = "Please enter state"
    static let msgAddress = "Please enter address"
    static let msgLocality = "Please enter locality or town"
    static let msgCity = "Please enter city or district"
    
    static let msgPassword = "Please enter password"
    static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 16 characters"
    static let msgValidPassword = "Password should contain atleast one uppercase letter, one lowercase letter, one digit and one special character with minimum eight character length"
    
    //General Delete Message
    static let msgGeneralDelete = "Are you sure you want to delete?"
    
    //Logout Message
    static let msgLogout = "Are you sure you want to logout from the application?"
}
