//
//  MainModule.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import InoMvvmc

protocol MainModuleInput: AnyObject {}

protocol MainModuleOutput: AnyObject {}

final class MainModule: BaseModule<MainModuleInput, MainModuleOutput> {}
