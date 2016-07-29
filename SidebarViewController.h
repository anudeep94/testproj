//
//  SidebarViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 20/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SidebarViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

@property(weak, nonatomic) IBOutlet UITableView *tableView1;

@end
