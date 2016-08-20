//
//  FirstPGViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 20/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "FirstPGViewController.h"

@interface FirstPGViewController ()

@end

@implementation FirstPGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text= [NSString stringWithFormat:@"Screen#%ld",(long)self.index+1 ];
    CGRect newFrame=self.view.frame ;
    newFrame.size.height =newFrame.size.height - 100;
    UIImage *img1 = [UIImage imageNamed:@"KL.jpg"];
     UIImage *img2 = [UIImage imageNamed:@"Pulikali.jpg"];
     //UIImage *img3 = [UIImage imageNamed:@"KL.jpg"];
    if(_index == 0)
    [_imageView setImage:img1];
    if (_index==1) {
        [_imageView setImage:img2];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
