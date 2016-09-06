//
//  MoreInfoViewController.h
//  GetStrongTryout
//
//  Created by vm mac on 06/09/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *poiImageView;
@property (weak, nonatomic) IBOutlet UILabel *poiTitleLabel;
@property (weak, nonatomic) IBOutlet UITextView *poiDetailsText;
@property (nonatomic) NSDictionary *poiDetails;

@end
