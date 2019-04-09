/*
 * lin_func.hpp
 *
 *  Created on: Oct 2, 2014
 *      Author: zhanglin
 */

#ifndef LIN_FUNC_HPP_
#define LIN_FUNC_HPP_
#include <stdio.h>
#include <stdlib.h>
#include "rplidar.h" //RPLIDAR standard sdk, all-in-one header
#include <unistd.h>
#include <stdio.h>
#include <math.h>
#include <vector>
#include <float.h>
#include <string.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#ifndef _countof
#define _countof(_Array) (int)(sizeof(_Array) / sizeof(_Array[0]))
#endif
using namespace rp::standalone::rplidar;

u_result capture_and_display2(RPlidarDriver * drv, size_t* detected_counts, rplidar_response_measurement_node_t* detected_nodes);

#endif /* LIN_FUNC_HPP_ */
