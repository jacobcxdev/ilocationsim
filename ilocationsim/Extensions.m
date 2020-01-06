//
//  Extensions.m
//  ilocationsim
//
//  Created by Jacob Clayden on 05/01/2020.
//  Copyright © 2020 JacobCXDev. All rights reserved.
//

#import "Extensions.h"

@implementation NSError (libimobiledevice)

+ (NSError *)errorWithDeviceErrorCode:(idevice_error_t)errorCode {
    NSDictionary *errorCodes = @{
        [NSNumber numberWithInt:IDEVICE_E_SUCCESS]: @"Success",
        [NSNumber numberWithInt:IDEVICE_E_INVALID_ARG]: @"Invalid argument",
        [NSNumber numberWithInt:IDEVICE_E_NO_DEVICE]: @"No device connected",
        [NSNumber numberWithInt:IDEVICE_E_NOT_ENOUGH_DATA]: @"Not enough data",
        [NSNumber numberWithInt:IDEVICE_E_SSL_ERROR]: @"SSL error",
        [NSNumber numberWithInt:IDEVICE_E_TIMEOUT]: @"Timed out",
        [NSNumber numberWithInt:IDEVICE_E_UNKNOWN_ERROR]: @"Unknown error"
    };
    if (!errorCodes[[NSNumber numberWithInt:errorCode]]) {
        return nil;
    }
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorCodes[[NSNumber numberWithInt:errorCode]]};
    return [NSError errorWithDomain:@"com.jacobcxdev.ilocationsim.ErrorDomain" code:errorCode userInfo:userInfo];
}

+ (NSError *)errorWithServiceErrorCode:(service_error_t)errorCode {
    NSDictionary *errorCodes = @{
        [NSNumber numberWithInt:SERVICE_E_SUCCESS]: @"Success",
        [NSNumber numberWithInt:SERVICE_E_INVALID_ARG]: @"Invalid argument",
        [NSNumber numberWithInt:SERVICE_E_MUX_ERROR]: @"Mux Protocol error",
        [NSNumber numberWithInt:SERVICE_E_SSL_ERROR]: @"SSL error",
        [NSNumber numberWithInt:SERVICE_E_START_SERVICE_ERROR]: @"Start service error",
        [NSNumber numberWithInt:SERVICE_E_NOT_ENOUGH_DATA]: @"Not enough data",
        [NSNumber numberWithInt:SERVICE_E_TIMEOUT]: @"Timed out",
        [NSNumber numberWithInt:SERVICE_E_UNKNOWN_ERROR]: @"Unknown error"
    };
    if (!errorCodes[[NSNumber numberWithInt:errorCode]]) {
        return nil;
    }
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: errorCodes[[NSNumber numberWithInt:errorCode]]};
    return [NSError errorWithDomain:@"com.jacobcxdev.ilocationsim.ErrorDomain" code:errorCode userInfo:userInfo];
}

@end
