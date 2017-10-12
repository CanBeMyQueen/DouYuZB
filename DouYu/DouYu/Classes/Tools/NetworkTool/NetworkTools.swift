//
//  NetworkTools.swift
//  DouYu
//
//  Created by 张萌 on 2017/10/12.
//  Copyright © 2017年 JiaYin. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

class NetworkTools {
    /**
     * 类请求数据方法
     *  paratemers:
     *      type: 请求类型，GET 和 POST
     *      urlString: 请求 URL路径
     *      paratemers: 请求参数
     *      finistedCallback: 回调函数
     */
    class func requestData(type : MethodType, urlString : NSString, parameters : [String : String]? = nil, finisedCallback : (_ result : AnyObject) -> ()) {

// 1.获取 method
        let method = type == .GET ? Method. : Method.POST
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
    }
}
