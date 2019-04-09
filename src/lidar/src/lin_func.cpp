/*
 * lin_func.cpp
 *
 *  Created on: Oct 2, 2014
 *      Author: zhanglin
 */
#include "lin_func.hpp"

u_result capture_and_display2(RPlidarDriver * drv, size_t* detected_counts, rplidar_response_measurement_node_t* detected_nodes)
{
    u_result ans;
    rplidar_response_measurement_node_t nodes[360*2];
    size_t   count = _countof(nodes);
    ans = drv->grabScanData(nodes, count);
    for(int i=0;i<(int)count;i++)
    	*(detected_nodes+i)=nodes[i];
    *detected_counts = count;
    if (IS_OK(ans) || ans == RESULT_OPERATION_TIMEOUT) {
        drv->ascendScanData(nodes, count);
    } else {
        printf("error code: %x\n", ans);
    }

    return ans;
}
