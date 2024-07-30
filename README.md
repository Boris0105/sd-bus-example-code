check the functionalities

(1) system bus:  busctl introspect com.example.SystemCalculator /com/example/SystemCalculator


(2) user bus  :  busctl --user introspect net.poettering.Calculator /net/poettering/Calculator

preprocess:

(1)
sudo apt update
sudo apt install gcc make pkg-config libsystemd-dev dbus-x11 policykit-1


(2) check the dbus service is running
# systemctl status dbus


(3) start dbus service
# sudo systemctl start dbus


(4) create Dbus service document
# sudo nano /etc/dbus-1/system.d/com.example.SystemCalculator.conf
Add the followings into the file:

<!DOCTYPE busconfig PUBLIC "-//freedesktop//DTD D-BUS Bus Configuration 1.0//EN"
 "http://www.freedesktop.org/standards/dbus/1.0/busconfig.dtd">
<busconfig>
  <policy user="openbmc">
    <allow own="com.example.SystemCalculator"/>
    <allow send_destination="com.example.SystemCalculator"/>
    <allow send_interface="com.example.SystemCalculator"/>
  </policy>
</busconfig>


(5) restart Dbus service
# sudo systemctl restart dbus


(6) Make sure the service is registerred on system bus service
# busctl list
# busctl tree com.example.SystemCalculator
# busctl introspect com.example.SystemCalculator /com/example/SystemCalculator




