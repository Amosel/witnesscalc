#include "witnesscalc_onAddLeaf.h"
#include "witnesscalc.h"

#define CICRUIT_NAME onAddLead

int witnesscalc_onAddLeaf(
    const char *circuit_buffer, unsigned long circuit_size,
    const char *json_buffer, unsigned long json_size,
    char *wtns_buffer, unsigned long *wtns_size,
    char *error_msg, unsigned long error_msg_maxsize)
{
    return CIRCUIT_NAME::witnesscalc(circuit_buffer, circuit_size,
                                     json_buffer, json_size,
                                     wtns_buffer, wtns_size,
                                     error_msg, error_msg_maxsize);
}
