//
//  BaseModule.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import UIKit

protocol BaseModuleProtocol {
    /// Определяет набор данных, необходимых модулю для начала работы/инициализации
    /// Такими данными могут быть: режим открытия (модально или новым экраном), объект, редактируемый пользователем, и т.д.
    associatedtype Input
    
    /// Определяет набор данных, необходимых модулю для завершения работы
    /// К их числу относятся, например, обработчики завершения пользовательского сценария с каким-то результатом
    /// Пример - onCancel(), onPhotoSelected(photo), onCreatedTask(task), и т.д.
    associatedtype Output
    
    var view: UIViewController { get }
    var input: Input { get }
    var output: Output { get }
}

/// Базовый класс для всех модулей в приложении.
class BaseModule<Input, Output>: BaseModuleProtocol {
    public let view: UIViewController
    public let input: Input
    public let output: Output
    
    init(view: UIViewController, input: Input, output: Output) {
        self.view = view
        self.input = input
        self.output = output
    }
}
