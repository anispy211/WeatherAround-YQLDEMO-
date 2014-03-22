//
//  ViewController.m
//  WeatherAround
//
//  Created by Aniruddha  on 23/01/14.
//  Copyright (c) 2014 @nispy. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    AppDelegate * app;
    IBOutlet UITableView * cityWeatherListView;
    IBOutlet UITextField * citynameTextFiel;
    IBOutlet UIButton * getWeathetbtn;
    IBOutlet UIButton * locatebtn;

}
- (IBAction)GetWeatherButtonAction:(id)sender;
- (IBAction)locateMeButtonAction:(id)sender;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    app = WAAppDelegate;
    [self configureUI];
    [self configureCurrentUserLocation];
   
    weatherDF = [[WeatherForecastDataFetcher alloc] init];
    [weatherDF setDelegate:self];
//    [self getWeatherforCitys:@[@"Pune",@"Delhi",@"Goa"]];

    
}


- (void)configureUI
{
    self.title = @"Weather Around";
    
    [cityWeatherListView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cityWeatherListView.layer setBorderWidth:1];
    [cityWeatherListView.layer setCornerRadius:8];

    [getWeathetbtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [getWeathetbtn.layer setBorderWidth:1];
    [getWeathetbtn.layer setCornerRadius:4];
    [locatebtn.layer setBorderColor:[UIColor grayColor].CGColor];
    [locatebtn.layer setBorderWidth:0.5];
    [locatebtn.layer setCornerRadius:4];

}



-(void)configureCurrentUserLocation{
    
    
    
    locationMgr = [[CLLocationManager alloc] init];
    //[tkLocationManager disallowDeferredLocationUpdates];
    [locationMgr setDelegate:self];
    locationMgr.distanceFilter = kCLDistanceFilterNone;
    locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    locationMgr.distanceFilter=10.0;
    
    if([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied){
        [WAAppDelegate showHUDActivityIndicator:@"Identifying Your location"];
        
        [locationMgr startUpdatingLocation];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Location Services are unavailable" message:@"Location cannot be determined" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
       // NSArray * cityArr = [[Utility sharedInstance] getCityDataFromPlist:City_Plist];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")) {
        
        
        location = [locations lastObject];
        
        NSLog(@"STOP UPDATE: Update");
        
        CLGeocoder *clGeocoder = [[CLGeocoder alloc]init];
        [clGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *placeMark = [placemarks lastObject];
            
            //  NSDictionary * addressDict = [placeMark addressDictionary];
            
            for(CLPlacemark *placemark in placemarks){
                NSLog(@"location //// %@",[placemark location]);
                NSLog(@"locality  %@",[placemark locality]); }
            
            CLLocation *loc = [placeMark location];
            
            CLLocationCoordinate2D cor2D = [loc coordinate];
            
            
            [SVGeocoder reverseGeocode:cor2D completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
                if([placemarks count] > 6){
                    [locationMgr stopUpdatingLocation];
                    [WAAppDelegate hideHUDActivityIndicator];
                    NSDictionary *addDict = [placemarks objectAtIndex:5];
                    NSString *address = [addDict valueForKey:@"formattedAddress"];
                    NSArray *arr = [address componentsSeparatedByString:@","];
                    NSString *city = [arr objectAtIndex:0];
                    NSLog(@"The City is : %@ ", city);
                    
                    if (city) {
                        
                        [self getWeatherforCitys:@[city]];
                        
                        NSString * msg = [NSString stringWithFormat:@"Your location is identified as %@",city];
                        
                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alert show];
                       
                    }
                    
                    if ([arr objectAtIndex:0] != nil) {
                 
                    }
                    
                }
                
                
            }];
        }];
        [locationMgr stopUpdatingLocation];
        
    }

}

#pragma mark - UItextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [citynameTextFiel resignFirstResponder];
    
    return YES;
}


#pragma mark - Button Action

- (IBAction)locateMeButtonAction:(id)sender
{
    [self configureCurrentUserLocation];
}


- (IBAction)GetWeatherButtonAction:(id)sender
{
    if (([citynameTextFiel.text isEqualToString:@""])) {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Please enter city names" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSArray* cityNameArray = [citynameTextFiel.text componentsSeparatedByString: @","];
    [self getWeatherforCitys:cityNameArray];
    [citynameTextFiel resignFirstResponder];
    
    [app showHUDActivityIndicator:@"Fetching data..."];
}

#pragma mark - Fetch City info
- (void) getWeatherforCitys : (NSArray *) cityArr
{
    if (cityInfoArr) {
        cityInfoArr = nil;
    }
    cityInfoArr = [[NSMutableArray alloc] init];
    
    if ([cityArr count] > 0) {
        [weatherDF setIsDownloading:YES];
        
        for (int i = 0; i <[cityArr count]; i++) {
            NSString * str = [cityArr objectAtIndex:i];
            [weatherDF getWeatherHistoryForCity:str];
        }
        
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"No City Name Entered" message:@"Please enter city name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        [app hideHUDActivityIndicator];
        
        [app hideHUDActivityIndicator];

        [app hideHUDActivityIndicator];


    }
    
    
    
}


#pragma mark - WeatherForecastDataFetcherDelegate

- (void) setCityWeatherInfo:(CityModel *)cityM
{
    if (cityM) {
    CityModel * cityTemp = [[CityModel alloc] init];
    cityTemp = cityM;
    cityTemp.mainDict = cityM.mainDict;
    [cityInfoArr addObject:cityTemp];
    
    NSLog(@"CityArray %@",cityInfoArr.description);
    [cityWeatherListView reloadData];
    }
    [app hideHUDActivityIndicator];

    
}

- (void) errorNotification:(NSString *)errorMsg
{
    [app hideHUDActivityIndicator];

}

#pragma mark - CityWetherList TableView Delegates


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return  [cityInfoArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"WListCustomCell";
    //3
    WeatherListCustomCell *cell = (WeatherListCustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        NSArray *nibbb=[[NSBundle mainBundle] loadNibNamed:@"WeatherListCustomCell" owner:self options:nil];
        cell=(WeatherListCustomCell *) [nibbb objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    
    
    
    
    CityModel * cityM = (CityModel *) [cityInfoArr objectAtIndex:indexPath.row];
    
    if (cityM != nil) {
        cell.cityNameLbl.text = cityM.cityName;
        cell.tempLbl.text = [NSString stringWithFormat:@"Temp: %@",[cityM.mainDict valueForKey:@"temp"]];
        [cell.arrowImg setImage:[UIImage imageNamed:@"arrow"]];
        cell.btn.tag = indexPath.row;
        
        [cell.btn addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchUpInside];

    }
    else{
        cell.cityNameLbl.text = @"";
        cell.tempLbl.text = @"";
        [cell.arrowImg setImage:nil];

    }
    
   
    
    return cell;
}


- (void)btnAction1:(UIButton *)sender
{
    
    CityModel * cityM = (CityModel *) [cityInfoArr objectAtIndex:sender.tag];

    DetailViewController * detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [detailVC setTitle:cityM.cityName];
    detailVC.dataArr = [cityInfoArr objectAtIndex:sender.tag];
    
    [self.navigationController pushViewController:detailVC animated:YES];

    
}


//
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    DetailViewController * detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
//    detailVC.dataArr = [cityInfoArr objectAtIndex:indexPath.row];
//    
//    [self.navigationController pushViewController:detailVC animated:YES];
//    
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    return 1;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
