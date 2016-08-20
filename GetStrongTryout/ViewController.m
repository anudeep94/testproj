//
//  ViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 07/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FirstPGViewController.h"

@interface ViewController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pageTitles = @[@"God's Own Country", @"Paradise on Earth", @"Garden City"];
    FirstPGViewController *initalViewController =[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObjects:initalViewController, nil];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource=self;
    self.pageController.delegate = self;
   
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
   // [[self view] addSubview:_subViewForPG];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self.view bringSubviewToFront:self.pageControl];
    [self.view bringSubviewToFront:_headingLabel];
    [self.view bringSubviewToFront:_loginButton];
    [self.view bringSubviewToFront:_singupButton];
    [self.view bringSubviewToFront:_sepLabel];
    [self.pageControl setNumberOfPages:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (FirstPGViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    FirstPGViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstPGViewController"];
    pageContentViewController.titleLabel = self.pageTitles[index];
    pageContentViewController.index = index;
    
    return pageContentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
    NSUInteger index = [(FirstPGViewController*)viewController index];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    //    [self.pageControl setCurrentPage:index];
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(FirstPGViewController *)viewController index];
    
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [self.pageTitles count]) {
        return nil;
    }
    //    [self.pageControl setCurrentPage:index];
    return [self viewControllerAtIndex:index];
    
}
-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    FirstPGViewController *vc = (FirstPGViewController*)[pendingViewControllers objectAtIndex:0];
    
    self.pageControl.currentPage = vc.index;
}



@end
