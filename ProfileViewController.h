//
//  ProfileViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 22/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UIButton *ratingButton;
@property (weak, nonatomic) IBOutlet UIButton *exceButton;
@property (weak, nonatomic) IBOutlet UIButton *goodButton;
@property (weak, nonatomic) IBOutlet UIButton *satButton;
@property (weak, nonatomic) IBOutlet UIButton *notBadButton;
@property (weak, nonatomic) IBOutlet UIButton *needBUtton;
@property (weak, nonatomic) IBOutlet UIView *rateView;





@property (weak, nonatomic) IBOutlet UIButton *sendDataButton;
@end
