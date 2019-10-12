#ifndef __FYOS_H__
#define __FYOS_H__
// Pointer to the Mailstation firmware version
// versionpointer[0] is the minor version
// versionpointer[1] is the major version
volatile unsigned char *versionpointer = (volatile unsigned char *)0x0036;
#endif // __FYOS_H__
