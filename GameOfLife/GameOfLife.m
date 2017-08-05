//
//  GameOfLife.m
//  GameOfLife
//
//  Created by Marianne Glad on 8/5/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import "GameOfLife.h"

@implementation GameOfLife



- (void)setupBoard:(Settings *)settings
{
    int dimensions = settings.dimensions;
        
    self.board = [NSMutableArray arrayWithCapacity:dimensions];
        
    for(int x = 0; x < dimensions; x++)
    {
        self.board[x] = [NSMutableArray arrayWithCapacity:dimensions];
        for(int y = 0; y < dimensions;y++)
        {
            self.board[x][y] = @NO;
        }
    }
    [self setLivingCells:settings];
}

- (void) setLivingCells:(Settings *) settings
{
    int seed = settings.seed;
    int startingPopulation = settings.startingPopulation;
    int dimensions = settings.dimensions;
    int dimensionsSquared = dimensions*dimensions;
    if(startingPopulation > dimensionsSquared)
        [NSException raise:@"Initial population is higher than dimensions squared" format:@"starting population %i > dimensions squared %i", startingPopulation, dimensionsSquared];
    NSMutableSet *alreadyExists = [[NSMutableSet alloc]init];
    srandom(seed);
    while(startingPopulation > 0)
    {
        int toActivate = random()%dimensionsSquared;
        if(![alreadyExists containsObject: [NSNumber numberWithInt: toActivate]])
        {
            [alreadyExists addObject:[NSNumber numberWithInt:toActivate]];
            int x =  floorf((((float)toActivate)/((float)dimensions)));
            int y = toActivate%settings.dimensions;
            self.board[x][y] = @YES;
            startingPopulation--;
        }
    }
}

- (instancetype) initWithSettings : (Settings*) settings
{
    if(self = [super init])
    {
        self.settings = settings;
        
        [self setupBoard:settings];
    }
    return self;
}

- (NSArray*) tick
{
    NSMutableArray* localBoard = self.board;
    for(int x = 0; x < [localBoard count]; x++)
    {
        for(int y = 0; y < [localBoard count]; y++)
        {
            [self processindexWithX:x withY:y withBoard:localBoard];
        }
    }
    return localBoard;
}

- (void) processindexWithX : (int) xIndex withY : (int) yIndex withBoard : (NSMutableArray*) board
{
    int neighbourCount = 0;
    for(int x = xIndex-1; x < xIndex+2; x++)
    {
        for(int y = yIndex-1; y <yIndex+2;y++)
        {
            if(x > 0 && x < [board count] && y > 0 && y < [board count] && !(x == xIndex && y == yIndex))
            {
                if([board[x][y] boolValue])
                {
                    neighbourCount++;
                }
            }
        }
    }
    bool alive = [board[xIndex][yIndex] boolValue];
    if(alive)
    {
        if(!(neighbourCount > 1 && neighbourCount < 4))
            board[xIndex][yIndex] = @NO;
    }
    else
    {
        if(neighbourCount == 3)
            board[xIndex][yIndex] = @YES;
    }
}

@end
