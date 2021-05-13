//
//  APIResponseSerializing.swift
//  4billioSDK
//
//  Created by Yelyzaveta Kartseva on 16.04.2021.
//

import Alamofire
import Marshal
import Foundation

private let emptyDataStatusCodes: Set<Int> = [202, 204, 205]

func APIObjectJSONResponseSerializer<T: Unmarshaling>(type: T.Type, preprocessor: DataPreprocessor) -> DataResponseSerializer {
    return APIObjectResponseSerializer(preprocessor: preprocessor, type: type)
}

func APIObjectResponseSerializer<T: Unmarshaling>(preprocessor: DataPreprocessor, type: T.Type) -> DataResponseSerializer {
    return DataResponseSerializer(dataPreprocessor: preprocessor, emptyResponseCodes: emptyDataStatusCodes)
}

