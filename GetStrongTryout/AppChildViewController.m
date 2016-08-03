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
    self.screenNumber.text= [NSString stringWithFormat:@"Screen#%ld",(long)self.index+1 ];
    
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    if(screenBounds.size.height==480)
    {
        CGRect titleLabelFrame, descriptLabelFrame;
//        titleLabelFrame=self.view.frame;
//        descriptLabelFrame=self.view.frame;
        titleLabelFrame=_titleLabel.frame;
        descriptLabelFrame=_descriptLabel.frame;
        titleLabelFrame.origin.y=350;
        descriptLabelFrame.origin.y=360;
        
        _titleLabel.frame=titleLabelFrame;
        _descriptLabel.frame=descriptLabelFrame;
       
    }
    UIImage *img1 = [UIImage imageNamed:@"KL.jpg"];
    [_bgImageView setImage:img1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
