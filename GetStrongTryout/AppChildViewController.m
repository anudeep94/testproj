//
//  AppChildViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 28/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "AppChildViewController.h"

@interface AppChildViewController (){
    NSArray *contentData;
    NSDictionary *contentDic1, *contentDic2, *contentDic3;
    NSString *imageName;
    UIImage *imageForBG;
}

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
//    UIImage *img1 = [UIImage imageNamed:@"KL.jpg"];
//    [_bgImageView setImage:img1];
    
    contentData=[[NSUserDefaults standardUserDefaults] objectForKey:@"AppInitData"];
    contentDic1= contentData[0];
    contentDic2=contentData[1];
    contentDic3=contentData[2];
    
    
    if (self.index ==0) {
        _descriptLabel.text= [contentDic1 valueForKey:@"content"];
        NSURL *imagUrl=[contentDic1 valueForKey:@"img"];
       _bgImageView.image = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:imagUrl]];
        _titleLabel.text=[contentDic1 valueForKey:@"heading"];
    }
    else if (self.index ==1){
    
    }
    else if(self.index == 2){
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
