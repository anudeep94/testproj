//
//  FirstPGViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 20/08/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstPGViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (assign, nonatomic) NSInteger index;

@end
