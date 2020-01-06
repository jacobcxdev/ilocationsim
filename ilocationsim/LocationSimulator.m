//
//  LocationSimulator.m
//  ilocationsim
//
//  Created by Jacob Clayden on 05/01/2020.
//  Copyright © 2020 JacobCXDev. All rights reserved.
//

#import "LocationSimulator.h"

@implementation LocationSimulator

typedef enum RunCode : int {
    start = 0x0000000,
    stop = 0x1000000
} RunCode;

- (id)initWithDevice:(idevice_t)device {
    self = [super init];
    self.device = device;
    return self;
}

- (int)writeString:(const char *)string toClient:(service_client_t)client {
    int length = (int)strlen(string);
    int swappedLength = htonl(length);

    service_error_t sendError = service_send(client, (void *)&swappedLength, 4, nil);
    if (sendError != SERVICE_E_SUCCESS) {
        fprintf(stderr, "Error writing string\n");
        return sendError;
    }

    return service_send(client, string, length, nil);
}

- (service_error_t)newClientSimulationWithRunCode:(RunCode)runCode client:(service_client_t *)client {
    char *serviceID = "com.apple.dt.simulatelocation";

    service_error_t clientErrorCode = service_client_factory_start_service(self.device, serviceID, (void **)client, "com.jacobcxdev.ilocationsim", nil, nil);
    if (clientErrorCode != SERVICE_E_SUCCESS) {
        fprintf(stderr, "Could not connect to service client\n");
        return clientErrorCode;
    }

    service_error_t startSimulationErrorCode = service_send(*client, (void *)&runCode, 4, nil);
    if (startSimulationErrorCode != SERVICE_E_SUCCESS) {
        fprintf(stderr, "Error starting simulation\n");
        return startSimulationErrorCode;
    }

    return SERVICE_E_SUCCESS;
}

- (int)simulateLocationWithLatitude:(const char *)latitude longitude:(const char *)longitude {
    service_client_t client = nil;

    service_error_t clientSimulationErrorCode = [self newClientSimulationWithRunCode:start client:&client];
    if (clientSimulationErrorCode != SERVICE_E_SUCCESS) {
        fprintf(stderr, "Could not create client simulation\n");
        return clientSimulationErrorCode;
    }

    service_error_t latitudeErrorCode = [self writeString:latitude toClient:client];
    if (latitudeErrorCode != SERVICE_E_SUCCESS) {
        fprintf(stderr, "Could not write latitude\n");
        return latitudeErrorCode;
    }

    service_error_t longitudeErrorCode = [self writeString:longitude toClient:client];
    if (longitudeErrorCode != SERVICE_E_SUCCESS) {
        fprintf(stderr, "Could not write longitude\n");
        return longitudeErrorCode;
    }

    fprintf(stdout, "%s\n", [[NSString stringWithFormat:@"Simulating location with geographic coordinates (%s, %s).", latitude, longitude] UTF8String]);
    service_client_free(client);
    return SERVICE_E_SUCCESS;
}

- (int)stopLocationSimulation {
    service_client_t client = nil;

    service_error_t clientSimulationErrorCode = [self newClientSimulationWithRunCode:stop client:&client];
    if (clientSimulationErrorCode != SERVICE_E_SUCCESS) {
        return clientSimulationErrorCode;
    }

    fprintf(stdout, "Stopped location simulation.\n");
    service_client_free(client);
    return SERVICE_E_SUCCESS;
}

@end
