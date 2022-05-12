//
//  WeatherSocket.swift
//  AirQuality
//
//  Created by Srikanth SP on 10/05/22.
//

import Foundation
import Starscream
import UIKit



enum WebSocketError: Error {
    case invalidDataFormat
    case error(message:String)
}

extension WebSocketError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidDataFormat:
            return NSLocalizedString("The data recieved is not in a valid format.", comment: "Invalid Data Format")
        case .error(let message):
            return NSLocalizedString("Error Message: \(message)", comment: "Error Message")
        }
    }
}


protocol WeatherSocketDelegate {
    func connectionChanged(_ isConnected: Bool)
    func recievedData(_ result: Result<[AQIData], Error>)
}

class WeatherSocket {
   static let WeatherHerokuUrl = "ws://city-ws.herokuapp.com/"
    
   static let TestSocketUrl = "wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self"
    
    static var shared: WeatherSocket = {
        return WeatherSocket()
    }()
    
    private init() {}
    
    var isConnected =  false
    private var socket: WebSocket?
    private var currentUrl = ""
    var delegate: WeatherSocketDelegate?
    
    func configure(url: String) {
        if url != currentUrl {
            disconnect()
            socket?.delegate = self
        }
        var request = URLRequest(url: URL(string: url)!)
        request.timeoutInterval = 5.0
        socket = WebSocket(request: request)
        socket?.delegate = self
        currentUrl = url
    }
    
    func connect() {
        if !isConnected{
            socket?.connect()
        }
    }
    
    func disconnect() {
        if isConnected {
            socket?.disconnect()
        }
    }
    
    func handleError(_ error: Error) {
        if let e = error as? WSError {
            delegate?.recievedData(.failure(WebSocketError.error(message: e.message)))
            print("websocket encountered an WSError: \(e.message)")
        } else  {
            delegate?.recievedData(.failure(error))
            print("websocket encountered an Error: \(error.localizedDescription)")
        }
    }
}

extension WeatherSocket: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
            isConnected = true
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let text):
            print("Received text: \(text)")
            do {
                let entities = try JSONDecoder().decode([AQIData].self, from: Data(text.utf8))
                delegate?.recievedData(.success(entities))
            }
            catch{
                delegate?.recievedData(.failure(WebSocketError.invalidDataFormat))
            }
        case .binary(let data):
            print("Received data: \(data.count)")
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            break
        case .cancelled:
            isConnected = false
        case .error(let error):
            isConnected = false
            handleError(error!)
        }
    }
}

extension Date {
    static func currentTimestamp() -> Double {
        return Date.now.timeIntervalSince1970
    }
}
