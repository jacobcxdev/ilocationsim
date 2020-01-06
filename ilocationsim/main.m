//
//  main.m
//  ilocationsim
//
//  Created by Jacob Clayden on 04/01/2020.
//  Copyright © 2020 JacobCXDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libimobiledevice/libimobiledevice.h>
#import <libimobiledevice/service.h>
#import "LocationSimulator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        idevice_t device;
        char *udid = nil;

        idevice_error_t deviceErrorCode = idevice_new_with_options(&device, udid, IDEVICE_LOOKUP_USBMUX | IDEVICE_LOOKUP_NETWORK);
        if (deviceErrorCode != IDEVICE_E_SUCCESS) {
            fprintf(stderr, "%s\n", [[NSError errorWithDeviceErrorCode:deviceErrorCode].localizedDescription UTF8String]);
            return deviceErrorCode;
        }
        if (!udid) idevice_get_udid(device, &udid);

        LocationSimulator *locationSimulator = [[LocationSimulator alloc] initWithDevice: device];

        double latitude;
        double longitude;
        fprintf(stdout, "Please enter the latitude coordinate of the location to be simulated: ");
        scanf("%lf", &latitude);
        fprintf(stdout, "Please enter the longitude coordinate of the location to be simulated: ");
        scanf("%lf", &longitude);
        fprintf(stdout, "\n");

        service_error_t startSimulationErrorCode = [locationSimulator simulateLocationWithLatitude:[[NSString stringWithFormat:@"%lf", latitude] UTF8String] longitude:[[NSString stringWithFormat:@"%lf", longitude] UTF8String]];
        if (startSimulationErrorCode != SERVICE_E_SUCCESS) {
            fprintf(stderr, "%s\n", [[NSError errorWithServiceErrorCode:startSimulationErrorCode].localizedDescription UTF8String]);
            return startSimulationErrorCode;
        }

        fprintf(stdout, "\nPress any character key followed by \u23CE to stop the location simulation...\n");
        scanf(" ");
        fprintf(stdout, "\n");

        service_error_t stopSimulationErrorCode = [locationSimulator stopLocationSimulation];
        if (stopSimulationErrorCode != SERVICE_E_SUCCESS) {
            fprintf(stderr, "%s\n", [[NSError errorWithServiceErrorCode:stopSimulationErrorCode].localizedDescription UTF8String]);
            return stopSimulationErrorCode;
        }
    }
    return 0;
}
