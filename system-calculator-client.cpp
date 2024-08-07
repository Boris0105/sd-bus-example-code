#include <sdbusplus/bus.hpp>
#include <iostream>
#include <stdexcept>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <int1> <int2>" << std::endl;
        return EXIT_FAILURE;
    }

    try {
        auto bus = sdbusplus::bus::new_system();

        int a = std::stoi(argv[1]);
        int b = std::stoi(argv[2]);

        auto method = bus.new_method_call("com.example.SystemCalculator",
                                          "/com/example/SystemCalculator",
                                          "com.example.SystemCalculator",
                                          "Multiply");

        method.append(a, b);

        auto reply = bus.call(method);

        int64_t result;
        reply.read(result);

        std::cout << "Result: " << result << std::endl;
    } catch (const sdbusplus::exception::SdBusError &e) {
        std::cerr << "Failed to issue method call: " << e.what() << std::endl;
        return EXIT_FAILURE;
    } catch (const std::invalid_argument &e) {
        std::cerr << "Invalid argument: " << e.what() << std::endl;
        return EXIT_FAILURE;
    } catch (const std::exception &e) {
        std::cerr << "An error occurred: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}

