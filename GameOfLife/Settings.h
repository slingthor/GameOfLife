//
//  Settings.h
//  GameOfLife
//
//  Created by Marianne Glad on 8/4/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject
@property(nonatomic) int dimensions;
@property(nonatomic) int seed;
@property(nonatomic) int startingPopulation;

+ (Settings*) withDimensions : (int) dimensions withSeed : (int) seed withStartingPopulation : (int) startingPopulation;

@end
