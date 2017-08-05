//
//  Settings.m
//  GameOfLife
//
//  Created by Marianne Glad on 8/4/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import "Settings.h"

@implementation Settings

+ (Settings*) withDimensions : (int) dimensions withSeed : (int) seed withStartingPopulation : (int) startingPopulation
{
    return [[Settings alloc] initWithDimensions:dimensions withSeed:seed withStartingPopulation:startingPopulation];
}

- (instancetype) initWithDimensions : (int) dimensions withSeed : (int) seed withStartingPopulation : (int) startingPopulation
{
    if(self = [super init])
    {
        self.dimensions = dimensions;
        self.seed = seed;
        self.startingPopulation = startingPopulation;
    }
    return self;
}

@end
