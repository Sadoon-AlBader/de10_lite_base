Base configuration for an Altera DE10 Lite board using VHDL.

What this project does:
    It defines all the pins for a DE10 Lite board so that one can program it without having to use the "Pin Planner".
    Two folders are included:
    de10_lite_base:
        This includes only the bare minimum pins.
    de10_lite_counter:
        This is a full project that counts in hexadecimal on the seven segment displays, and resets on button press.

How to use:
    Just open either project in Quartus Prime and compile and upload.
    