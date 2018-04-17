#ifndef RESOURCE_TABLE_H
#define RESOURCE_TABLE_H

#include <stddef.h>
#include <rsc_types.h>

#pragma DATA_SECTION(pru_remoteproc_ResourceTable, ".resource_table")
#pragma RETAIN(pru_remoteproc_ResourceTable)
struct resource_table pru_remoteproc_ResourceTable = {
    1, // version number
    0, // entry count
    0, 0, // reserved
};

#endif /* RESOURCE_TABLE_H */

