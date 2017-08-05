//
//  ViewController.m
//  GameOfLife
//
//  Created by Marianne Glad on 8/4/17.
//  Copyright © 2017 slingthor. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "Settings.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UITextField *dimensions;
@property (weak, nonatomic) IBOutlet UITextField *seed;
@property (weak, nonatomic) IBOutlet UITextField *startingPopulation;

@end

@implementation MenuViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"MenuToGame"])
    {
        GameViewController *gameViewController =
        [segue destinationViewController];
        int dimensionsNum = [[self.dimensions text] integerValue];
        int seedNum = [[self.seed text] integerValue];
        int startingPopulationNum = [[self.startingPopulation text] integerValue];
        gameViewController.settings = [Settings withDimensions:dimensionsNum withSeed:seedNum withStartingPopulation:startingPopulationNum];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dimensions.text = @"200";
    self.seed.text = @"1234";
    self.startingPopulation.text = @"3000";
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [tapGesture setCancelsTouchesInView:NO];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

@end
