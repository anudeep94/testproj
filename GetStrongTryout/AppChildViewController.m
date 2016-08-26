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
    NSString *imageURL;
    UIImage *imageForBG;
}

@end

@implementation AppChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.screenNumber.text= [NSString stringWithFormat:@"Screen#%ld",(long)self.index+1 ];
    
    
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
   // NSLog(@"Content Dic1 : %@",contentDic1);
    
    
    if (self.index ==0) {
        _descriptLabel.text= [contentDic1 valueForKey:@"content"];
        imageURL= [contentDic1 valueForKey:@"img"];
       // NSURL *imagUrl=[contentDic1 valueForKey:@"img"];
       //_bgImageView.image = [UIImage imageWithCIImage:[CIImage imageWithContentsOfURL:imagUrl]];
        NSURL *url = [NSURL URLWithString:imageURL];
        NSData *urlContent = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:urlContent];
        [_bgImageView setImage:img];
        _titleLabel.text=[contentDic1 valueForKey:@"heading"];
        _screenNumber.text=[contentDic1 valueForKey:@"mainheading"];
        //[_titleLabel sizeToFit];
        //[_titleLabel setCenter:self.view.center];
    }
    else if (self.index ==1){
        _descriptLabel.text= [contentDic2 valueForKey:@"content"];
        imageURL= [contentDic2 valueForKey:@"img"];
        NSURL *url = [NSURL URLWithString:imageURL];
        NSData *urlContent = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:urlContent];
        [_bgImageView setImage:img];
        _titleLabel.text=[contentDic2 valueForKey:@"heading"];
        _screenNumber.text=[contentDic2 valueForKey:@"mainheading"];
    
    }
    else if(self.index == 2){
        _descriptLabel.text= [contentDic3 valueForKey:@"content"];
        imageURL= [contentDic3 valueForKey:@"img"];
        NSURL *url = [NSURL URLWithString:imageURL];
        NSData *urlContent = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:urlContent];
        [_bgImageView setImage:img];
        _titleLabel.text=[contentDic3 valueForKey:@"heading"];
        _screenNumber.text=[contentDic3 valueForKey:@"mainheading"];
    
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
