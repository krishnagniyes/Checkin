//
//  ICGLoginViewController.m
//  iCheckInGenie
//
//  Created by Krishna on 19/02/14.
//  Copyright (c) 2014 Gniyes Inc... All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ICGLoginViewController.h"

@interface ICGLoginViewControllerTests: XCTestCase
{
    ICGLoginViewController *_loginVC;
}
@end

@implementation ICGLoginViewControllerTests

- (void)setUp
{
    [super setUp];
    _loginVC = [[ICGLoginViewController alloc] init];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

//- (void)testExample
//{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
//}

- (void)testSampleTest
{
    NSString* str = [_loginVC testSample:@"abc"];
    
    XCTAssertTrue([str isEqualToString:@"Krishna = abc"], @"Pass");
}

@end
