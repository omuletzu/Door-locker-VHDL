## Door-locker-VHDL

# Specifications
This project shows the internal architecture of an application for securing cabinets. Its operation can be described as follows: the user must enter 3 characters in a row, representing the numbers from 0 to 9 to which the letters A - F are added, to secure the locker. After the cabinet is secured. To select the digits, the user uses the AD_CIFRU button, and the UP and DOWN buttons. The RESET button is intended to delete what is on the SSD display, and if it is blocked, after pressing the button the cabinet remains blocked. The MASTER_RESET button resets the entire application to its initial state.
To open the locker, the user must enter the code correctly.
The entered code appears on the 7-segment BCD display.

# Projection

- **Block diagram**

![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/60bf8f2b-22c1-488c-965b-2da80883a012)

*Black box of the system with the inputs and outputs set*

- **Control Unit and Execution Unit**

![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/79fb1164-acc8-4903-baa3-1d719c9960c5)

*Mapping the inputs and outputs of the big box onto the two components UC and UE*


- **Control inputs**: buttons "START", "AD_CIF", "RESET", "UP", "DOWN" synchronous signal "CLK".

- **Control outputs**: “FREE_OCUPAT”, “INTR_CIF

- **Data inputs**: and all the LEDs present on the 3 "SSDs".

- **Resource determination (EU)**
  
To highlight the links between the control unit and the execution unit, it is necessary to identify the resources. There are resources on the basis of which decisions will be made, but also resources that serve as information for the user. These resources can generate signals to the control unit, and can be controlled by means of global inputs, such as "RESET", "MASTER_RESET" or the synchronous signal "CLK".

  - *Comparator of two 4-bit numbers*
    
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/48d22615-06af-46be-a8f6-c82bb34af1ea)

  - *Reversible counter 1-15*
 
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/474144a7-daa0-4f82-b4c5-f61fcaeb8953)

  - *Register with two 4-bit inputs*
 
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/f6b9ffc5-402d-438c-b6bd-85e65c1139cb)

  - *7-Segment Decoder (SSD)*
 
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/ff8ee57d-d85c-42b3-b1d2-a5da9afd239d)

  - *4:1 multiplexer with 4-bit inputs*
 
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/66ea2140-a6cf-4902-a6c6-bff515a1b003)

  - *4:1 multiplexer with 7-bit inputs*
 
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/9e4b3580-2cbf-4dd5-953b-dc24cfde0cfe)

  - *15-bit counter*
 
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/6e3c733a-27ab-4b8c-9bb8-6a5322f520cf)


    
- **Schema bloc a primei descompuneri**

  
  ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/e813ef07-b410-43f2-9ad5-62b589126405)

  *Block diagram of the first decomposition*

- **Detailed scheme of the project**

  
    ![image](https://github.com/omuletzu/Door-locker-VHDL/assets/75565975/85790147-6042-4e91-8233-258d082cb333)


- **Operation and Maintenance Manual**

  **Functional requirements:**
  
**1.** A FREE_OCCUPIED LED will have the function of signaling that the cabinet is free (LED off) or occupied (LED on).

**2.** The user will press an ADD NUMBER button to signal the start of entering the code. An INTRODU_CARACTERE led will light up to mark the status.

**3.** The user will add 3 characters in a row using the UP and DOWN buttons.

**4.** The characters are included in the range 0-1-..-8-9-A-B-..-F

**5.** The current character is displayed on the SSD.

**6.** To move to the next character, the user will press the ADD DIGIT button.

**7.** The previously entered character remains displayed.

**8.** The next character is visible on the display in the next position.

**9.** After entering the third character, upon pressing the ADD_CIFRU button, the SSD display will turn off and the code will be locked by lighting the FREE_BUSY LED.

**10.** The ENTER CHARACTER LED will turn off.

**11.** The existence of a RESET button/switch during the entry of the code to return to the initial state (the LIBER_OCUPAT led will go out, the SSD display is empty, the INTRODU_CARACTERE led will go out).

**12.** The user will press the ADD CODE button/switch to start entering the code to unlock the code.

**13.** Steps 2-8 will be repeated.

**14.** When entering the last character, upon pressing the ADD DIGIT button, a check will be made, if the entered code corresponds to the previous code.

**15.** In the event of a tie, the FREE BUSY led will go out, the INTRODU_CHARACTERS led will go out, the SSD display will go blank.

**16.** In case of inequality, the LIBER_OCUPAT led will remain lit, the INTRODU_CHARCATERE led will go out, the SSD display will go blank.


  **Non-functional requirements:** 
  - Implementation on the board
  - SSD usage 
  - Use switch, led, buttons

  **Example use case:**
  The user chooses a case with the Free_occupied LED off. Click on the button ADAUGA_CIFRU to enter the characters. The character "0" is visible on the SSD. Enter the first character "2" by pressing the DOWN button twice. On the SSD, the display changes once by pressing the button, namely: 0->1->2. The user presses ADD_DIGIT again to enter the second character "1". The user presses ADD_DIGIT again to enter the second character "3". The user presses ADD_CIFRU again, the code is saved, the ssd content is empty, the FREE_OCUPAT led is on, the INTRODU_CHARACTERS led will turn off.

  **Justification of the chosen solution**
  The solution chosen by us is an efficient one and meets all requirements. We achieved this by using components:
  
 - *Comparator of two 4-bit numbers* – this component takes as inputs two 4-bit numbers and a clock, and the returned result is 0, if the two numbers are not equal, or 1, if the two are equal. We need it to perform the final check between two pairs of registers, respectively a register and the counter value.

 - *Reversible counter 1-15* – the user changes its value by means of the UP and DOWN buttons, and this value is to be stored in one of the five registers. The counter is synchronous. If the LOAD input has the value 1, it acts as a reset and gives it the value 0, otherwise it does not reset.

 - *4-bit two-input register* – is an essential component because it stores the value returned by the counter, and the values from them will be compared at the end to decide whether the locker unlocks or not. The register is synchronous, the input D is what is to be memorized, MEM_CIF has the role of enable, if it is 1 the value is memorized, otherwise not, and RESET resets the register to 0. At the same time, it has as outputs Q the same number of bits as D (4 bits), and INIT which takes the value 1 if a value was stored in the register, otherwise 0.

 - *7-segment decoder (SSD)* - for this component we will use several sub-components including: the 7-segment decoder, two 4:1 multiplexers, one with 4-bit inputs to decide which anode is activated and one with 7-bit inputs to set the cathodes. The selections for the two multiplexers will be the first 2 most significant bits of the result of a 15-bit counter. Thus all these together generate a vector of anodes and one of cathodes. The inputs of the decoder will be the 5 numbers from the registers (NR1, ... ,NR5), the output from the 4-bit reversible counter (Q), the INIT signals from the registers (INIT1, ... , INIT5) which check if the register has stored a value, the clock (CLK), the vector of anodes (ANOD), the value of the FREE_BUSY signal, to determine if we use the lock or unlock registers and ON_OFF, which takes the value of INTR_CIF to determine if it lights up display or not. Its role is to check if the display lights up and to establish the 7 cathodes.

  - *4:1 multiplexer with 4-bit inputs* – has as inputs the four possible combinations for the anodes and the two-bit selection (the first two significant bits of the 15-bit number). The role is to form the anode vector, by which it is decided to turn on a specific display.

 - *4:1 multiplexer with 7-bit inputs* – has as inputs the four possible combinations for the cathodes and the two-bit selection (the first two significant bits of the 15-bit number). It is important to form the vector of cathodes, which subsequently ignites the segments.

 - *15-bit counter* – has only the clock as input. It will count in 15 bits from 0 to the maximum value and output that number.


  **Posibilități de dezvoltări ulterioare**
  
  - Expanding the possibilities of choosing characters for the cipher, so the code could be much more difficult for someone else to guess. Instead of characters 0 to F, we can have 0 to Z.
    
  - Extending the number of memorized digits, so instead of 3, more characters could be memorized. The user could even choose how many digits they want their digit to have.
    
  - To increase the security level of the locker, the user has the possibility to use the fingerprint or facial recognition. At the same time, a master key can be used, which acts like the master reset in the system.

    
