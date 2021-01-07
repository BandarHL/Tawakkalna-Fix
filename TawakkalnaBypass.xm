#import <UIKit/UIKit.h>
#import "Classes/Network/PonyDebugger/FLEXNetworkObserver.h"


%config(generator=internal)

%group SwizzURLRequest
%hook NSMutableURLRequest
- (void)setValue:(id)arg1 forHTTPHeaderField:(id)arg2 {
    if ([arg1 isKindOfClass:NSClassFromString(@"NSString")]) {
        if ([arg2 containsString:@"ibaklvl"]) {
            arg1 = nil;
        }
        if ([arg2 containsString:@"bak"]) {
            arg1 = nil;
        }
        if ([arg2 containsString:@"twk-client-datetime"]) {
            arg1 = nil;
        }
        return %orig(arg1, arg2);
    } else {
        return %orig;
    }
}
- (void)addValue:(id)arg1 forHTTPHeaderField:(id)arg2 {
    if ([arg1 isKindOfClass:NSClassFromString(@"NSString")]) {
        if ([arg2 containsString:@"ibaklvl"]) {
            arg1 = nil;
        }
        if ([arg2 containsString:@"bak"]) {
            arg1 = nil;
        }
        if ([arg2 containsString:@"twk-client-datetime"]) {
            arg1 = nil;
        }
        return %orig(arg1, arg2);
    } else {
        return %orig;
    }
}
%end

%hook NSURLSession
- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request {
    NSMutableURLRequest *req = request;
    [req setValue:nil forHTTPHeaderField:@"ibaklvl"];
    [req setValue:nil forHTTPHeaderField:@"bak"];
    [req setValue:nil forHTTPHeaderField:@"twk-client-datetime"];
    request = req;
    return %orig(request);
}

- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    NSMutableURLRequest *req = request;
    [req setValue:nil forHTTPHeaderField:@"ibaklvl"];
    [req setValue:nil forHTTPHeaderField:@"bak"];
    [req setValue:nil forHTTPHeaderField:@"twk-client-datetime"];
    request = req;
    return %orig(request, completionHandler);
}
%end
%end

%ctor {
    [FLEXNetworkObserver injectIntoAllNSURLConnectionDelegateClasses];
    %init(SwizzURLRequest);
}
