//
//  Extensions.h
//  ilocationsim
//
//  Created by Jacob Clayden on 05/01/2020.
//  Copyright © 2020 JacobCXDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libimobiledevice/libimobiledevice.h>
#import <libimobiledevice/service.h>

@interface NSError (libimobiledevice)

+ (NSError *)errorWithDeviceErrorCode:(idevice_error_t)errorCode;
+ (NSError *)errorWithServiceErrorCode:(service_error_t)errorCode;

@end
