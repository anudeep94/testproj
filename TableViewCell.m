//
//  TableViewCell.m
//  GetStrongTryout
//
//  Created by vm mac on 25/07/2016.
//  Copyright © 2016 PytenLabs. All rights reserved.


#import "TableViewCell.h"
#import "SidebarViewController.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

     //Configure the view for the selected state
//   if (selected) {
//       UIImage * image = [UIImage imageNamed:@"menu.png"];
//       _idImage.highlightedImage = image;
//       //_idImage.tintColor = [UIColor colorWithRed:0.839 green:0.682 blue:0.047 alpha:1];
//      // [_idImage tintColorDidChange];
//            }
//   else {
//       UIImage * image = [UIImage imageNamed:@""];
//       _idImage.image = image;
//       //_idImage.setBackground=image;
//       _idImage.tintColor = [UIColor blackColor];
//       [_idImage tintColorDidChange];
//   }
}
//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
//{
//    if (highlighted) {
//        self.textLabel.textColor = [UIColor whiteColor];
//    }
//    else {
//        self.textLabel.textColor = [UIColor blackColor];
//    }
////    UIView *bgColorView = [[UIView alloc] init];
////    bgColorView.backgroundColor = [UIColor colorWithRed:0.161 green:0.749 blue:0.612 alpha:1.00];
//
//
//}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
   // [super setSelected:selected animated:animated];
    
    UIView * selectedBackgroundView = [[UIView alloc] init];
    [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:0.161 green:0.749 blue:0.612 alpha:1.00]]; // set color here
    [self setSelectedBackgroundView:selectedBackgroundView];
   // if (highlighted) {
        //UIImageView * setbgc =[[UIImageView alloc] init];
        //_idImage.backgroundColor= [UIColor grayColor];
//        UIImage *image = [[UIImage imageNamed:@"menu icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        imageView.tintColor = [UIColor redColor];
        
    //}
    if (highlighted) {
        UIImage * image = [UIImage imageNamed:@"menu.png"];
        _idImage.highlightedImage = image;
        //_idImage.tintColor = [UIColor colorWithRed:0.839 green:0.682 blue:0.047 alpha:1];
        // [_idImage tintColorDidChange];
    }
    else{
        UIImage * image = [UIImage imageNamed:@"Image"];
        _idImage.highlightedImage = image;
    
    }
}


@end
