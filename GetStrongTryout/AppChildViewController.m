//
//  AppChildViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 28/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "AppChildViewController.h"

@interface AppChildViewController ()

@end

@implementation AppChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.screenNumber.text= [NSString stringWithFormat:@"Screen#%ld",(long)self.index ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
