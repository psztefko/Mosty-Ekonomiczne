//
//  LoggerModule.swift
//  TravelApp
//
//  Created by Patryk Jastrzębski on 10/06/2023.
//

import Foundation

// swiftlint: disable all
public struct LoggerModule: Codable, Equatable, Hashable {

    /**
     Initializes custom module that can be used in app.
     - Parameters:
        - name: long name that describes the module
        - prefix: short emoji, that is noticeable and recognizable
     - Returns: a new module
    */
    public init(_ name: String, prefix: String = "✏️") {
        self.name = name
        self.prefix = prefix
    }

    /// Network - 🌐
    public static let network           = LoggerModule("Network" ,prefix: "🌐")

    /// Request - 📤
    public static let networkRequest    = LoggerModule("Request" ,prefix: "📤")

    /// Response - 📥
    public static let networkResponse   = LoggerModule("Response" ,prefix: "📥")

    /// WebSocket - 🔌
    public static let webSocket         = LoggerModule("WebSocket" ,prefix: "🔌")

    /// WebSocket Request - ↗️
    public static let webSocketRequest  = LoggerModule("WebSocketRequest" ,prefix: "↗️")

    /// WebSocket Response - ↘️
    public static let webSocketResponse = LoggerModule("WebSocketResponse" ,prefix: "↘️")

    /// UserDefaults - 💾
    public static let userDefaults      = LoggerModule("UserDefaults" ,prefix: "💾")

    /// KeyChain - 🔑
    public static let keyChain          = LoggerModule("KeyChain" ,prefix: "🔑")

    /// DataBase - 🗳
    public static let dataBase          = LoggerModule("DataBase" ,prefix: "🗳")

    /// Synchronizer - 🔄
    public static let synchronizer      = LoggerModule("Synchronizer" ,prefix: "🔄")

    /// ScreenView - 📱
    public static let screenView        = LoggerModule("ScreenView" ,prefix: "📱")

    /// Auth - 🛡
    public static let auth              = LoggerModule("Auth" ,prefix: "🛡")

    /// Background - 🐜
    public static let background        = LoggerModule("Background" ,prefix: "🐜")

    /// Calendar - 📅
    public static let calendar          = LoggerModule("Calendar" ,prefix: "📅")

    /// Time - ⏰
    public static let time              = LoggerModule("Time" ,prefix: "⏰")

    /// Cache - 💽
    public static let cache             = LoggerModule("Cache" ,prefix: "💽")

    /// Bug - 🪲
    public static let bug               = LoggerModule("Bug" ,prefix: "🪲")

    /// Camera - 📸
    public static let camera           = LoggerModule("Camera", prefix: "📸")

    /// To do - 🔧
    public static let todo              = LoggerModule("To do" ,prefix: "🔧")

    /// Payments - 💰
    public static let payments          = LoggerModule("Payments" ,prefix: "💰")

    /// Settings - ⚙️
    public static let settings          = LoggerModule("Settings" ,prefix: "⚙️")

    /// Map - 🗺
    public static let map               = LoggerModule("Map" ,prefix: "🗺")

    /// Security - 🔐
    public static let security          = LoggerModule("Security" ,prefix: "🔐")

    /// Notifications - 🔔
    public static let notifications     = LoggerModule("Notifications" ,prefix: "🔔")

    /// Analytics - 📮
    public static let analytics         = LoggerModule("Analytics" ,prefix: "📮")

    /// Push - ⚡️
    public static let push              = LoggerModule("Push" ,prefix: "⚡️")

    /// Language - 👅
    public static let language          = LoggerModule("Language" ,prefix: "👅")

    /// Configuration - 🎛
    public static let configuration     = LoggerModule("Configuration" ,prefix: "🎛")

    /// Environment - 🌳
    public static let environment       = LoggerModule("Environment" ,prefix: "🌳")

    /// Deeplink - ⛓
    public static let deeplink          = LoggerModule("Deeplink" ,prefix: "⛓")

    /// Refresh - 🔁
    public static let refresh           = LoggerModule("Refresh" ,prefix: "🔁")

    /// Status - 🟢
    public static let status            = LoggerModule("Status" ,prefix: "🟢")

    /// Logout - ♿️
    public static let logout            = LoggerModule("Logout" ,prefix: "♿️")

    /// AppState - 🚀
    public static let appState          = LoggerModule("AppState" ,prefix: "🚀")

    /// Device - ⚙️
    public static let device            = LoggerModule("Device", prefix: "⚙️")

    /// LOG - 🖊
    public static let unknown           = LoggerModule("LOG" ,prefix: "🖊")

    public let prefix: String
    public let name: String

}
