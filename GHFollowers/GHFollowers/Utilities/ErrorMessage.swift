//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 6/9/21.
//

import Foundation

enum GFError: String, Error {
    case invaildUserName = "username is invaild please try again!."
    case unableToConnect = "Unable to connect, please check ypou interent"
    case errorWithServer = "there are error with server, please try again!."
    case invaildData     = "the data recived from server is in invaild."
    case unableToFavorite =  "There was an error favorting this user,, please try again."
    case aleardyInFavorites = "You've aleardy favorited this user."
}
