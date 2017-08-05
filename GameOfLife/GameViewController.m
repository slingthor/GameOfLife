//
//  GameViewController.m
//  GameOfLife
//
//  Created by Marianne Glad on 8/4/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()


@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UIView *gameSpace;

@end

@implementation GameViewController

NSMutableArray *boardViews;
UIColor *lifeColor;
NSTimer *updateTimer;
GameOfLife* gameOfLife;

- (void)viewDidLoad {
    [super viewDidLoad];
    lifeColor = [UIColor grayColor];
    gameOfLife = [[GameOfLife alloc]initWithSettings:self.settings];
    [self setupGameView];
}

- (void) viewDidAppear:(BOOL)animated
{
    updateTimer = [self setRenderLoopWithMilliSeconds:0.2f];
}

- (void) viewDidDisappear:(BOOL)animated
{
    updateTimer = nil;
}

- (IBAction)openMenu:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:true];
}

- (void) setupGameView
{
    CGRect viewBounds = self.view.bounds;
    CGFloat morePixels = viewBounds.size.height < viewBounds.size.width ? viewBounds.size.height : viewBounds.size.width;
    CGFloat pixelsPerSquare = floor(morePixels/((CGFloat)self.settings.dimensions));
    CGFloat actualSize =  pixelsPerSquare*self.settings.dimensions;
    CGFloat halfSize = morePixels/2;
    self.gameSpace.frame = CGRectMake((morePixels-actualSize)/2, self.view.bounds.size.height/4, actualSize, actualSize);
    [self buildBoardViewsWithSize:pixelsPerSquare];
    //build subviews
}

- (void) buildBoardViewsWithSize : (CGFloat) pixelsPerSquare
{
    int dimensions = self.settings.dimensions;
    boardViews = [NSMutableArray arrayWithCapacity:dimensions];
    for(int x = 0; x < dimensions; x++)
    {
        boardViews[x] = [NSMutableArray arrayWithCapacity:dimensions];
        for(int y = 0; y < dimensions;y++)
        {
            UIView *boardView = [[UIView alloc]initWithFrame:CGRectMake(x*pixelsPerSquare, y*pixelsPerSquare, pixelsPerSquare, pixelsPerSquare)];
            [self.gameSpace addSubview:boardView];
            boardViews[x][y] = boardView;
        }
    }
}

-(NSTimer*) setRenderLoopWithMilliSeconds : (float) milliSeconds
{
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:milliSeconds repeats:true block:^(NSTimer * _Nonnull timer) {
        [self update];
    } ];
    return updateTimer;
}

-(void) renderWithBoard : (NSArray*) board;
{
    for(int x = 0; x < [board count];x++)
    {
        for(int y = 0; y < [board count];y++)
        {
            if([board[x][y] boolValue])
            {
                [boardViews[x][y] setBackgroundColor:lifeColor];
            }
            else
            {
                [boardViews[x][y] setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
}

-(void) update
{
    NSArray *currentTable = [gameOfLife tick];
    [self renderWithBoard:currentTable];
}

@end
