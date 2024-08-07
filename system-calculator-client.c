#include <stdio.h>
#include <stdlib.h>
#include <systemd/sd-bus.h>

#define UNUSED(x) (void)(x)

int main(int argc, char *argv[]) {
    UNUSED(argc);
    UNUSED(argv);

    sd_bus_error error = SD_BUS_ERROR_NULL;
    sd_bus_message *m = NULL;
    sd_bus *bus = NULL;
    int r;

    /* Connect to the system bus */
    r = sd_bus_open_system(&bus);
    if (r < 0) {
        fprintf(stderr, "Failed to connect to system bus: %s\n", strerror(-r));
        goto finish;
    }

    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    /* Issue the method call and store the response message in m */
    r = sd_bus_call_method(bus,
                           "com.example.SystemCalculator",           /* service to contact */
                           "/com/example/SystemCalculator",          /* object path */
                           "com.example.SystemCalculator",           /* interface name */
                           "Multiply",                               /* method name */
                           &error,                                   /* object to return error in */
                           &m,                                       /* return message on success */
                           "xx",                                     /* input signature */
                           a,b);                                    /* arguments */
    if (r < 0) {
        fprintf(stderr, "Failed to issue method call: %s\n", error.message);
        goto finish;
    }

    /* Parse the response message */
    int64_t result;
    r = sd_bus_message_read(m, "x", &result);
    if (r < 0) {
        fprintf(stderr, "Failed to parse response message: %s\n", strerror(-r));
        goto finish;
    }

    printf("Result: %ld\n", result);

finish:
    sd_bus_error_free(&error);
    sd_bus_message_unref(m);
    sd_bus_unref(bus);

    return r < 0 ? EXIT_FAILURE : EXIT_SUCCESS;
}

