//
//  SYSensorManager.m
//  SYCompassDemo
//
//  Created by 陈蜜 on 16/6/27.
//  Copyright © 2016年 sunyu. All rights reserved.
//

#import "SYSensorManager.h"

@interface SYSensorManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) CMMotionManager *motionManager;

@end

@implementation SYSensorManager

+ (instancetype)shared
{
    return [[self alloc]init];
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)startSensor
{
    _manager = [[CLLocationManager alloc]init];
    _manager.delegate = self;
    
    if ([CLLocationManager headingAvailable]) {
        _manager.headingFilter = 5;
        [_manager startUpdatingHeading];
    }
}

- (void)startGyroscope
{
    _motionManager = [[CMMotionManager alloc]init];
    
    if (_motionManager.deviceMotionAvailable) {
        _motionManager.deviceMotionUpdateInterval = 0.01f;
        __weak typeof(self)mySelf = self;
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                     withHandler:^(CMDeviceMotion *data, NSError *error) {
                                         
                                         if (mySelf.updateDeviceMotionBlock) {
                                             mySelf.updateDeviceMotionBlock(data);
                                         }
                                         
                                     }];
        
    }
}

- (void)stopSensor
{
    [_manager stopUpdatingHeading];
    _manager = nil;
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    if (_didUpdateHeadingBlock) {
        _didUpdateHeadingBlock(theHeading);
    }
}


@end
