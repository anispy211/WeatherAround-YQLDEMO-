//
//  DetailViewController.h
//  YqlDemo
//
//  Created by Aniruddha  on 12/03/14.
//  Copyright (c) 2014 aniruddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"
#import "ForecastModel.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UITableView * detailTableView;
}
@property (nonatomic,strong) CityModel * dataArr;
@end
