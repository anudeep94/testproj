//
//  SidebarViewController.m
//  GetStrongTryout
//
//  Created by vm mac on 20/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import "SidebarViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"

#import "TableViewCell.h"


@interface SidebarViewController ()

@end

@implementation SidebarViewController
{
    NSArray *menuItems;
        }

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    menuItems = @[@"username",@"location",@"home",@"logout"];
    self.tableView1.delegate= self;
    self.tableView1.dataSource=self;
    
    
//    self.tableView1.estimatedRowHeight = 162.0 ;
//    self.tableView1.rowHeight = UITableViewAutomaticDimension;
//   tableViewHeightConstraint.constant = _tableView1.contentSize.height;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    return 10;
    
}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    if (highlighted) {
//        self.textLabel.textColor = [UIColor whiteColor];
//    } else {
//        self.textLabel.textColor = [UIColor blackColor];
//    }
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    //NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    NSString* cellIdentifier;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        cellIdentifier=@"username";
        cell=[_tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    else if (indexPath.row == 1)
    {
        cellIdentifier=@"location";
        cell=[_tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    else if (indexPath.row < 9)
    {
        cellIdentifier=@"home";
        cell=[_tableView1 dequeueReusableCellWithIdentifier:cellIdentifier];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:0.404 green:0.867 blue:0.510 alpha:1.00];
        [cell setSelectedBackgroundView:bgColorView];

        UILabel *taggedLabel =(UILabel*) [cell viewWithTag:55];
        UIImageView *taggedImageView = (UIImageView*) [cell viewWithTag:56];
//        TableViewCell *sub = [[TableViewCell alloc] init];
//        sub.highlighted=[UIColor whiteColor];
        
        switch (indexPath.row)
        {
            case 1:
            {
                break;
            }
                case 2:
            {
                break;
            }
            case 3:
                {taggedLabel.text = @"My Trips";
                taggedImageView.backgroundColor= [UIColor blackColor];
                break;
                }
            case 4:{
                taggedLabel.text = @"Pay Now";
                taggedImageView.backgroundColor= [UIColor grayColor];
                break;
            }
            case 5:{
                taggedLabel.text = @"My Account";
                taggedImageView.backgroundColor= [UIColor redColor];
                break;
            }
            case 6:{
                taggedLabel.text = @"Support";
                taggedImageView.backgroundColor= [UIColor blueColor];
                break;
            }
            case 7:
            {
                taggedLabel.text = @"Feedback";
                taggedImageView.backgroundColor= [UIColor magentaColor];
                break;
            }
            case 8:
            {
                taggedLabel.text = @"Contact";
                taggedImageView.backgroundColor= [UIColor brownColor];
            }
            default:
                break;
        }
    }
  if (indexPath.row ==9) {
        cellIdentifier=@"logout";
        }
  if (nil == cell)
        {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"logout"];
        [[cell textLabel] setText:@"LogOut"];
        }

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
        return 178.0;
    return 55.0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger selectedRow;
    selectedRow= -1;
    
    switch (indexPath.row)
    {
        case 1:{
            break;
        }
        case 2:{
            [self performSegueWithIdentifier:@"homeSegue" sender:nil];
            break;
        }
            case 3:
        {
            [self performSegueWithIdentifier:@"tripSegue" sender:nil];break;
        }
        case 4:{
            [self performSegueWithIdentifier:@"paySegue" sender:nil];break;
        }
        case 5:{
            [self performSegueWithIdentifier:@"accSegue" sender:nil];break;
        }
        case 6:{
        [self performSegueWithIdentifier:@"supportSegue" sender:nil];break;
        }
        case 7:
        {
        [self performSegueWithIdentifier:@"aboutSegue" sender:nil];break;
        }
            
            case 8:
        {[self performSegueWithIdentifier:@"conSegue" sender:nil];break;}
            
            case 9:
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey: @"isLogin"];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *vC = [storyBoard instantiateViewControllerWithIdentifier:@"startNavi"];
            AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
            [appDelegate.window setRootViewController:vC];
            break;
        }
        default:break;
            
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    // Add your Colour.
    if(indexPath.row >=1 && indexPath.row<7){
    TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.idLabel setHighlightedTextColor: [UIColor whiteColor]];  //highlight colour
        
//        [cell.idImage setBackgroundColor:[UIColor whiteColor]];
//      UIImage *image = [[UIImage imageNamed:@"menu icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

//        cell.idImage.highlightedImage = [UIImage imageNamed:@"image"];
//        cell.idImage.userInteractionEnabled=NO;
//       cell.idImage.highlighted = YES;
        
        cell.idImage.highlighted=NO;
                
        
    }
}

@end

