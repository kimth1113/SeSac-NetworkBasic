//
//  TMDBMovieModel.swift
//  NetworkBasic
//
//  Created by 김태현 on 2022/08/03.
//

import Foundation

struct TMDBMovie {
    var date: String
    var genre: String = "Drama"
    var imgURL: String
    var rate: Double
    var title: String
    var people: String = "설경구, 조진웅"
}
