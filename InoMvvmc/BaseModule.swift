//
//  BaseModule.swift
//  InoMvvmc
//
//  Created by Yaroslav Magin on 03.01.2021.
//

import UIKit

public protocol BaseModuleProtocol {
    /// Defines data required by module to start working
    /// Such data could be: screen opening mode, data structure for viewing/editing, etc.
    associatedtype Input
    
    /// Defines data required by module to complete working
    /// That could be some completion closures
    /// For example - onCancel(), onPhotoSelected(photo), onCreatedTask(task), etc.
    associatedtype Output
    
    var view: UIViewController { get }
    var input: Input { get }
    var output: Output { get }
}

/// Base class for all modules in the application.
open class BaseModule<Input, Output>: BaseModuleProtocol {
    public let view: UIViewController
    public let input: Input
    public let output: Output
    
    public init(view: UIViewController, input: Input, output: Output) {
        self.view = view
        self.input = input
        self.output = output
    }
}
