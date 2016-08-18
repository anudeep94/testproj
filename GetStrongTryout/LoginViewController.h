//
//  LoginViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 07/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *mailLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordLabel;

@property (weak, nonatomic) IBOutlet UIButton *loginButton1;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;

@end
