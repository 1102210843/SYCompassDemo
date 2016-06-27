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
    
//    //2. Gravity 获取手机的重力值在各个方向上的分量，根据这个就可以获得手机的空间位置，倾斜角度等
//    double gravityX = _motionManager.deviceMotion.gravity.x;
//    double gravityY = _motionManager.deviceMotion.gravity.y;
//    double gravityZ = _motionManager.deviceMotion.gravity.z;
//    //获取手机的倾斜角度：
//    double zTheta = atan2(gravityZ,sqrtf(gravityX*gravityX+gravityY*gravityY))/M_PI*180.0;
//    double xyTheta = atan2(gravityX,gravityY)/M_PI*180.0;
//    //zTheta是手机与水平面的夹角， xyTheta是手机绕自身旋转的角度
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
    
    // Use the true heading if it is valid.
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?
                                       newHeading.trueHeading : newHeading.magneticHeading);
    if (_didUpdateHeadingBlock) {
        _didUpdateHeadingBlock(theHeading);
    }
}


@end
