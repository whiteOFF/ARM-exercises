/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           led.h
** Last modified Date:  2019-11-26
** Last Version:        V1.00
** Descriptions:        Prototypes of functions included in lib_led.c
** Correlated files:    lib_led.c
**--------------------------------------------------------------------------------------------------------       
*********************************************************************************************************/

/* lib_led */
void LED_init(void);
void LED_deinit(void);
void all_LED_on(void);
void all_LED_off(void);
void led4and11_on(void);
void led4_off(void);
void ledevenon_oddoff(void);
void led_on(unsigned int);
void led_off(unsigned int);

