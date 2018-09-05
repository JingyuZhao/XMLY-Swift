//
//  FMClassifyApi.swift
//  XMLY_Swift
//
//  Created by winbei on 2018/9/4.
//  Copyright © 2018年 HelloWorld_1986. All rights reserved.
//

import Foundation
import Moya
import HandyJSON
import Result

///MARK-设置请求头信息
let myEndpointClosure = {(target:FMClassifyApi) -> Endpoint in
    let url = target.baseURL.appendingPathComponent(target.path)
    let endpoint:Endpoint = Endpoint(
        url: url.absoluteString,
        sampleResponseClosure: {.networkResponse(200, target.sampleData) },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
    )
    
    return endpoint.adding(newHTTPHeaderFields: [
        "Content-Type" : "application/x-www-form-urlencoded",
        "ECP-COOKIE" : ""
        ])
}
///MARK - 请求超时时间
let requestClosure = {(endpoint: Endpoint, done: @escaping MoyaProvider<FMClassifyApi>.RequestResultClosure) in
    do {
        var request = try endpoint.urlRequest()
        request.timeoutInterval = 30
        done(.success(request))
    } catch {
        print("error:", error)
    }
    
}

// MARK - 自定义插件
public enum MyNetworkActivityChangeType{
    case began,ended
}
public final class MyNetworkActivityPlugin:PluginType{
    public typealias MyNetworkActivityClosure = (_ change: MyNetworkActivityChangeType,  _ target: TargetType) -> Void
    let myNetworkActivityClosure : MyNetworkActivityClosure
    
    public init(newNetworkActivityClosure:@escaping MyNetworkActivityClosure){
        self.myNetworkActivityClosure = newNetworkActivityClosure
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        myNetworkActivityClosure(.began,target)
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        myNetworkActivityClosure(.ended,target)
    }
    
}
//自定义插件使用
let myNetworkPlugin = MyNetworkActivityPlugin{(statue,target) in
    if statue == .began {
        //        SwiftSpinner.show("Connecting...")
        
        let api = target as! FMClassifyApi
        if api.show {
            print("我可以在这里写加载提示")
        }
        
        if !api.touch {
            print("我可以在这里写禁止用户操作，等待请求结束")
        }
        
        print("我开始请求\(api.touch)")
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    } else {
        //        SwiftSpinner.show("request finish...")
        //        SwiftSpinner.hide()
        print("我结束请求")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
}



let HomeClassifyProvider = MoyaProvider<FMClassifyApi>()




public enum FMClassifyApi{
    case classifyList
}
//请求配置
extension FMClassifyApi:TargetType{
    
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .classifyList: return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .classifyList:
            return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1"
        }
    }
     //请求类型
    public var method: Moya.Method {
        return .get
    }
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .classifyList:return .requestPlain
        }
    }
    
    //请求头
    public var headers: [String: String]? {
        return nil
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    
    //以下两个参数是我自己写，用来控制网络加载的时候是否允许操作，跟是否要显示加载提示，这两个参数在自定义插件的时候会用到
    public var touch: Bool { //是否可以操作
        
        switch self {
        case .classifyList:
            return true
            
        }
    }
    
    public var show: Bool { //是否显示转圈提示
        
        switch self {
        case .classifyList:
            return true
            
        }
    }
        

}

