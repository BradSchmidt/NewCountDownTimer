//
//  HomeViewController.m
//  NewCountDownTimer
//
//  Created by Bradley Robert Schmidt on 4/28/14.
//  Copyright (c) 2014 Bradley Robert Schmidt. All rights reserved.
//

#import "HomeViewController.h"
#import "CountDownViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timer:(id)sender {
    CountDownViewController *countDown = [[CountDownViewController alloc] init];
    [[self navigationController] pushViewController:countDown animated:YES];
    
}
@end
