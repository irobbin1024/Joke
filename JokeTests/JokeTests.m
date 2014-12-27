//
//  JokeTests.m
//  JokeTests
//
//  Created by 赖隆斌 on 12/26/14.
//  Copyright (c) 2014 赖隆斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "JKNetworkUtil.h"
#import "JKViewControllerUtil.h"

@interface JokeTests : XCTestCase

@end

@implementation JokeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    [self measureBlock:^{
        // Put the code you want to measure the time of here.
//    }];
}

- (void)testJokeRequest
{
    [JKNetworkUtil requestJokeWithJokeType:JokeTypeNew pageNo:1 success:^(NSDictionary *jsonData) {
        XCTAssert(jsonData != nil, @"response data is empty");
        
        XCTAssert(YES, @"---------------------------> response data is %@", jsonData);
        
    } failure:^{
        
        XCTAssert(NO, @"request error");
    }];
}

@end
