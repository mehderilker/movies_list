//
//  ViperProtocols.swift
//  Movies
//
//  Created by ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import Foundation

protocol ViewEvent {}
protocol PresenterCommand {}
protocol InteractorRequest {}
protocol InteractorResponse {}

protocol ResponseListener {
    associatedtype Response: InteractorResponse
    func handle(response: Response)
}

protocol RequestListener {
    associatedtype Request: InteractorRequest
    func handle(request: Request)
}

protocol CommandListener {
    associatedtype Command: PresenterCommand
    func handle(command: Command)
}

protocol EventListener {
    associatedtype Event: ViewEvent
    func handle(event: Event)
}

class AnyEventListener<T: ViewEvent>: EventListener {
    typealias Event = T
    typealias Handler = ((T) -> Void)
    private let handler: Handler

    init(handler: @escaping Handler) {
        self.handler = handler
    }

    func handle(event: T) {
        self.handler(event)
    }
}

class AnyCommandListener<T: PresenterCommand>: CommandListener {
    typealias Command = T
    typealias Handler = ((T) -> Void)
    private let handler: Handler

    init(handler: @escaping Handler) {
        self.handler = handler
    }

    func handle(command: T) {
        self.handler(command)
    }
}

class AnyRequestListener<T: InteractorRequest>: RequestListener {
    typealias Request = T
    typealias Handler = ((T) -> Void)
    private let handler: Handler

    init(handler: @escaping Handler) {
        self.handler = handler
    }

    func handle(request: T) {
        self.handler(request)
    }
}

class AnyResponseListener<T: InteractorResponse>: ResponseListener {
    typealias Response = T
    typealias Handler = ((T) -> Void)
    private let handler: Handler

    init(handler: @escaping Handler) {
        self.handler = handler
    }

    func handle(response: T) {
        self.handler(response)
    }
}

protocol View: class, CommandListener {
    associatedtype Event: ViewEvent
    var eventListener: AnyEventListener<Event>? { get set }
}

protocol Interactor: class, RequestListener {
    associatedtype Response: InteractorResponse
    var responseListener: AnyResponseListener<Response>? { get set }
}

protocol Presenter: class, EventListener, ResponseListener {
    associatedtype Command: PresenterCommand
    associatedtype Request: InteractorRequest

    var requestListener: AnyRequestListener<Request>? { get set }
    var commandListener: AnyCommandListener<Command>? { get set }
}
