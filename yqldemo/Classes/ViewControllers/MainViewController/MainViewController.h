//
//  ViewController.h
//  WeatherAround
//
//  Created by Aniruddha  on 23/01/14.
//  Copyright (c) 2014 @nispy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SVGeocoder.h"
#import "SVPlacemark.h"
#import "Defines.h"
#import "WeatherForecastDataFetcher.h"
#import "DetailViewController.h"
#import "WeatherListCustomCell.h"

@interface MainViewController : UIViewController<CLLocationManagerDelegate,WeatherForecastDataFetcherDelegate,WeatherListCustomCellDelegate>
{
    CLGeocoder        * geocoder;
    CLLocationManager * locationMgr;
    CLLocation *location;
    WeatherForecastDataFetcher * weatherDF;
    NSMutableArray * cityInfoArr;
}
@end
