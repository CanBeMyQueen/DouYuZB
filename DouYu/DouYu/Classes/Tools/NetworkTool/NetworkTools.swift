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
    class func requestData(type : MethodType, urlString : String, parameters : [String : String]? = nil, finisedCallback : @escaping (_ result : AnyObject) -> ()) {

        // 1.获取 method 和 URL
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        let url = "\(kBaseUrl)\(urlString)"
        print(url)
        // 2.发送网络请求
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (dataresponse) in
//            print(dataresponse)
            guard let result = dataresponse.result.value else {
                print(dataresponse.result.error)
                return
            }
            finisedCallback(result as AnyObject)
        }
    }
}
