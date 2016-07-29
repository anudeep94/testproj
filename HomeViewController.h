//
//  HomeViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 12/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *mulButton;

@property (strong, nonatomic) UIPageViewController *pageController;
@end
