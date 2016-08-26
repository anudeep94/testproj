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

@interface HomeViewController ()<UIPageViewControllerDelegate> {
    NSInteger currentIndex;
    NSDictionary *jsonDic, *mainData, *stateDic1, *stateDic2, *dataDic;
    NSArray *states;
}

@end

BOOL buttonCurrentStatus;

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentIndex = 0;
    
    
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
   
    _pageTitles = @[@"God's Own Country", @"Paradise on Earth", @"Garden City"];
   
    CGRect newFrame=self.view.frame ;
    newFrame.size.height =newFrame.size.height - 50;
    
    AppChildViewController *initalViewController =[self viewControllerAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObjects:initalViewController, nil];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource=self;
    self.pageController.delegate = self;
    [self.pageController.view setFrame: newFrame];
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    [self.view bringSubviewToFront:self.pageControl];
    [self.pageControl setNumberOfPages:3];
    // self.screenTitle.text = [NSString stringWithFormat:@"%@", _pageTitles[(long)self.index]];
    
    
    NSString *urlString = [NSString stringWithFormat:
                           @"https://www.yatramantra.com/kerala/wp-admin/admin-ajax.php?action=androidapp_init"];
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if (error) {
                                   NSLog(@"error:%@", error.localizedDescription);
                               }
                               else{
                                   NSError *error = nil;
                                   jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                   
                                   if (error != nil) {
                                       NSLog(@"Error parsing JSON.");
                                   }
                                   else {
                                      NSArray *keyArray = jsonDic.allKeys;
                                
                                      // NSLog(@"DicKeys : %@",keyArray);
//                                       
//                                       for (NSString *key in keyArray) {
//                                           stateDic1= [jsonDic valueForKeyPath:key];
//                                           dataDic= [stateDic1 valueForKey:@"data"];
//                                           NSLog(@"stateData : %@",stateDic1);
//                                           NSLog(@"DicData : %@",dataDic);
//                                      }
                                       
                                       
                                       for (NSString *aKey in [jsonDic allKeys]) {
                                           NSDictionary *aValue = [jsonDic valueForKey:aKey];
                                          // NSLog(@"Key : %@", aKey);
                                          // NSLog(@"Value : %@", aValue);
                                           
                                           // Extract individual values
                                          // NSLog(@"Author : %@", [aValue objectForKey:@"data"]);
                                           NSArray *dataArray= [aValue objectForKey:@"data"];
                                          // NSLog(@"data Array : %@",dataArray);
                                            //If the titles are dynamic
                                          // for (NSString *aSubKey in [aValue allKeys]) {
                                              // NSString *aSubValue = [aValue objectForKey:aSubKey];
                                              // NSDictionary *value1 = dataArray[1];
                                              // NSLog(@" !!****** %@",value1);
                                           
                                           [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"AppInitData"];
                                           
                                             //  NSLog(@"SubKey : %@, SubValue = %@", aSubKey, aSubValue);
                                         //  }
                                       }
                                       
                                       
                                       
                                       //NSString *keyString =[NSString stringWithFormat:@"%@.data",keyArray[1]];
                                       //NSLog(@"Data to be loaded: %@", jsonDic);
                                       
                                       //stateDic2= [jsonDic valueForKeyPath:@"%@.data",keyArray[1]];
                                       
//                                       dispatch_async(dispatch_get_main_queue(), ^{
//                                           _nameTxtField.placeholder=[jsonDic3 valueForKey:@"displayname"];
//                                           
//                                       });
                                   }
                               }
                           }];
}




- (AppChildViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    AppChildViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AppChildViewController"];
    pageContentViewController.titleLabel = self.pageTitles[index];
    pageContentViewController.index = index;
    
    return pageContentViewController;
}


- (IBAction)updateScreen:(id)sender {
  
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


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    
    NSUInteger index = [(AppChildViewController*)viewController index];
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
//    [self.pageControl setCurrentPage:index];
    
    return [self viewControllerAtIndex:index];

}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(AppChildViewController *)viewController index];
    
    
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

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    AppChildViewController *vc = (AppChildViewController*)[pendingViewControllers objectAtIndex:0];
    
    self.pageControl.currentPage = vc.index;
}

//-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
//{
//    AppChildViewController *vc = (AppChildViewController*)[previousViewControllers objectAtIndex:0];
//    
//    NSLog(@"%ld",vc.index);
//}

@end
