//
//  HomeViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 12/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "SWRevealViewController.h"
#import "AppChildViewController.h"

@interface HomeViewController ()

@end

BOOL buttonCurrentStatus;

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //For PageController
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    CGRect newFrame;
    newFrame=self.view.frame ;
    newFrame.size.height =newFrame.size.height - 50;
    
    self.pageController.dataSource=self;
    [self.pageController.view setFrame: newFrame];
    //self.pageController.view.backgroundColor=[UIColor redColor];
    AppChildViewController *initalViewController =[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObjects:initalViewController, nil];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logoutAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"isLogin"];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"startNavi"];
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate.window setRootViewController:vC];
    
}

- (IBAction)onePress:(id)sender {
    [self performSegueWithIdentifier:@"oneSegue" sender:nil];
}
- (IBAction)mulPress:(id)sender {
    [self performSegueWithIdentifier:@"mulSegue" sender:nil];
}

- (AppChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
//    AppChildViewController *childViewController = [[AppChildViewController alloc] initWithNibName:@"AppChildViewController" bundle:nil];
    
    
    AppChildViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AppChildViewController"];
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AppChildViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AppChildViewController *)viewController index];
    
    
    index++;
    
    if (index == 3) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}
- (IBAction)changeState:(UIButton*)sender
{
    /* if we have multiple buttons, then we can
     differentiate them by tag value of button.*/
    // But note that you have to set the tag value before use this method.
    
    if([sender tag] == 101){
        
        if (buttonCurrentStatus == NO)
        {
            buttonCurrentStatus = YES;
            [_oneButton setBackgroundColor:[UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00]];
            //[self performSomeAction:sender];
        }
        else
        {
            buttonCurrentStatus = NO;
//            [_oneButton setBackgroundColor:[UIColor whiteColor]];
            //[self performSomeAction:sender];
        }   
    }
}

@end
