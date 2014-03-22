//
//  WeatherListCustomCell.h
//  YqlDemo
//
//  Created by Aniruddha  on 12/03/14.
//  Copyright (c) 2014 aniruddha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeatherListCustomCellDelegate <NSObject>

- (void)buttonAction:(NSInteger)index;

@end

@interface WeatherListCustomCell : UITableViewCell
@property (nonatomic,weak) IBOutlet UILabel * cityNameLbl;
@property (nonatomic,weak) IBOutlet UILabel * tempLbl;
@property (nonatomic,weak) IBOutlet UIImageView * arrowImg;
@property (nonatomic,weak) IBOutlet UIButton * btn;


@property(nonatomic, unsafe_unretained) id <WeatherListCustomCellDelegate> delegate;
@end
