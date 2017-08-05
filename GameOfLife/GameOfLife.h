//
//  GameOfLife.h
//  GameOfLife
//
//  Created by Marianne Glad on 8/5/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"

@interface GameOfLife : NSObject

@property (nonatomic) Settings* settings;

@property (nonatomic) NSMutableArray* board;

- (instancetype) initWithSettings : (Settings*) settings;

- (NSArray*) tick;

@end
