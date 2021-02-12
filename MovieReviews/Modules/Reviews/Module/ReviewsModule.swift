//
//  ReviewsModule.swift
//  MovieReviews
//
//  Created by Victor Rezvantsev on 05/02/2021.
//  Copyright © 2021 INOSTUDIO. All rights reserved.
//

import Foundation
import InoMvvmc

protocol ReviewsModuleInput: AnyObject {}

protocol ReviewsModuleOutput: AnyObject {}

final class ReviewsModule: BaseModule<ReviewsModuleInput, ReviewsModuleOutput> {}
