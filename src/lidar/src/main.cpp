/*
 * Copyright (C) 2014  RoboPeak
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
/*
 *  RoboPeak Lidar System
 *  Simple Data Grabber Demo App
 *
 *  Copyright 2009 - 2014 RoboPeak Team
 *  http://www.robopeak.com
 *
 */

#include "lin_func.hpp"
#define BUF_SIZE 3200

using namespace rp::standalone::rplidar;

union data{
	float f;
	int i;
};

void print_usage(int argc, const char * argv[])
{
    printf("Simple LIDAR data grabber for RPLIDAR.\n"
           "Usage:\n"
           "%s <com port> [baudrate]\n"
           "The default baudrate is 115200. Please refer to the datasheet for details.\n"
           , argv[0]);
}


void plot_histogram(rplidar_response_measurement_node_t * nodes, size_t count)
{
    const int BARCOUNT =  75;
    const int MAXBARHEIGHT = 20;
    const float ANGLESCALE = 360.0f/BARCOUNT;

    float histogram[BARCOUNT];
    for (int pos = 0; pos < _countof(histogram); ++pos) {
        histogram[pos] = 0.0f;
    }

    float max_val = 0;
    for (int pos =0 ; pos < (int)count; ++pos) {
        int int_deg = (int)((nodes[pos].angle_q6_checkbit >> RPLIDAR_RESP_MEASUREMENT_ANGLE_SHIFT)/64.0f/ANGLESCALE);
        if (int_deg >= BARCOUNT) int_deg = 0;
        float cachedd = histogram[int_deg];
        if (cachedd == 0.0f ) {
            cachedd = nodes[pos].distance_q2/4.0f;
        } else {
            cachedd = (nodes[pos].distance_q2/4.0f + cachedd)/2.0f;
        }

        if (cachedd > max_val) max_val = cachedd;
        histogram[int_deg] = cachedd;
    }

    for (int height = 0; height < MAXBARHEIGHT; ++height) {
        float threshold_h = (MAXBARHEIGHT - height - 1) * (max_val/MAXBARHEIGHT);
        for (int xpos = 0; xpos < BARCOUNT; ++xpos) {
            if (histogram[xpos] >= threshold_h) {
                putc('*', stdout);
            }else {
                putc(' ', stdout);
            }
        }
        printf("\n");
    }
    for (int xpos = 0; xpos < BARCOUNT; ++xpos) {
        putc('-', stdout);
    }
    printf("\n");
}


int main(int argc, const char * argv[]) {

	/*UDP client*/
    struct sockaddr_in server;
    int len = sizeof(struct sockaddr_in);
    char buf[BUF_SIZE];
    struct hostent *host;
    int s, port;

    int* nr_detected_counts;
    nr_detected_counts=(int*)malloc(sizeof(int));

    host = gethostbyname("localhost");
    port = 51068;

    /* initialize socket */
    if ((s=socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP)) == -1) {
        perror("socket");
        return 1;
    }

    /* initialize server addr */
    memset((char *) &server, 0, sizeof(struct sockaddr_in));
    server.sin_family = AF_INET;
    server.sin_port = htons(port);
    server.sin_addr = *((struct in_addr*) host->h_addr);


    const char * opt_com_path = NULL;
    _u32         opt_com_baudrate = 115200;
    u_result     op_result;


    if (argc < 2) {
        print_usage(argc, argv);
        return -1;
    }
    opt_com_path = argv[1];
    if (argc>2) opt_com_baudrate = strtoul(argv[2], NULL, 10);

    // create the driver instance
    RPlidarDriver * drv = RPlidarDriver::CreateDriver(RPlidarDriver::DRIVER_TYPE_SERIALPORT);

    if (!drv) {
        fprintf(stderr, "insufficent memory, exit\n");
        exit(-2);
    }

    rplidar_response_device_health_t healthinfo;
    rplidar_response_device_info_t devinfo;
    rplidar_response_measurement_node_t nodes[360*2];
    do {
        // try to connect
        if (IS_FAIL(drv->connect(opt_com_path, opt_com_baudrate))) {
            fprintf(stderr, "Error, cannot bind to the specified serial port %s.\n"
                , opt_com_path);
            break;
        }

        // retrieving the device info
        ////////////////////////////////////////
        op_result = drv->getDeviceInfo(devinfo);

        if (IS_FAIL(op_result)) {
            if (op_result == RESULT_OPERATION_TIMEOUT) {
                // you can check the detailed failure reason
                fprintf(stderr, "Error, operation time out.\n");
            } else {
                fprintf(stderr, "Error, unexpected error, code: %x\n", op_result);
                // other unexpected result
            }
            break;
        }

        op_result = drv->getHealth(healthinfo);
        if (IS_OK(op_result)) { // the macro IS_OK is the preperred way to judge whether the operation is succeed.
            printf("RPLidar health status : ");
            switch (healthinfo.status) {
            case RPLIDAR_STATUS_OK:
                printf("OK.");
                break;
            case RPLIDAR_STATUS_WARNING:
                printf("Warning.");
                break;
            case RPLIDAR_STATUS_ERROR:
                printf("Error.");
                break;
            }
            printf(" (errorcode: %d)\n", healthinfo.error_code);

        } else {
            fprintf(stderr, "Error, cannot retrieve the lidar health code: %x\n", op_result);
            break;
        }


        if (healthinfo.status == RPLIDAR_STATUS_ERROR) {
            fprintf(stderr, "Error, rplidar internal error detected. Please reboot the device to retry.\n");
            // enable the following code if you want rplidar to be reboot by software
            // drv->reset();
            break;
        }

        drv->startScan( /* true */ );
        union data temp_angle, temp_dist;

        while(1){
        capture_and_display2(drv,(size_t*)nr_detected_counts,nodes);
        unsigned short raw_angle_buf, raw_dist_buf;
    	for(int i=1;i<*nr_detected_counts+1;i++){
    		printf("temp_angle.f[%d] %03.2f temp_dist.f %08.2f\n",i, temp_angle.f, temp_dist.f);
    		temp_angle.f = (nodes[i].angle_q6_checkbit >> RPLIDAR_RESP_MEASUREMENT_ANGLE_SHIFT)/64.0f;
    		temp_dist.f = (nodes[i].distance_q2/4.0f);
    	}
    	for(int i=0;i<*nr_detected_counts*2;i++){


    		raw_angle_buf = nodes[i].angle_q6_checkbit;
    		raw_dist_buf = nodes[i].distance_q2;

    		for(int j=0;j<2;j++){
    			buf[i*4+j]=(raw_angle_buf>>(j*8))&0x00FF;
    			buf[i*4+j+2]=(raw_dist_buf>>(j*8))&0x00FF;
    		}
        }
    	printf("data sent=%d\n",*nr_detected_counts*4);

        if (sendto(s, buf, *nr_detected_counts*4, 0, (struct sockaddr *) &server, len) == -1) {
            perror("sendto()");
            return 1;
        }
        }

    } while(0);


    RPlidarDriver::DisposeDriver(drv);
    return 0;
}
