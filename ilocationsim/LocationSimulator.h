//
//  LocationSimulator.h
//  ilocationsim
//
//  Created by Jacob Clayden on 05/01/2020.
//  Copyright © 2020 JacobCXDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libimobiledevice/libimobiledevice.h>
#import <libimobiledevice/service.h>
#import "Extensions.h"

@interface LocationSimulator : NSObject

@property idevice_t device;

- (id)initWithDevice: (idevice_t)device;
- (int)simulateLocationWithLatitude:(const char *)latitude longitude:(const char *)longitude;
- (int)stopLocationSimulation;

@end
