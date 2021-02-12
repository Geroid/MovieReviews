//
//  CriticModule.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import InoMvvmc

protocol CriticModuleInput: AnyObject {}

protocol CriticModuleOutput: AnyObject {}

final class CriticModule: BaseModule<CriticModuleInput, CriticModuleOutput> {}
