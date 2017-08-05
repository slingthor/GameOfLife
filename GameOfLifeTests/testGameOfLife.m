//
//  testGameOfLife.m
//  GameOfLife
//
//  Created by Marianne Glad on 8/5/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameOfLife.h"

@interface testGameOfLife : XCTestCase

@end

@implementation testGameOfLife



- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testTick
{
    GameOfLife* gameOfLife = [[GameOfLife alloc]initWithSettings:[Settings withDimensions:4 withSeed:25 withStartingPopulation:9]];
    NSLog(@"%@",gameOfLife.board);
    NSArray* tick = [gameOfLife tick];
    NSLog(@"%@",tick);
    XCTAssertTrue(true);
}


@end
