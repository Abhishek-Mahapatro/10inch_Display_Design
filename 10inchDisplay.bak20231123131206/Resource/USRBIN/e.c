/* 
 * /////////////////////////////////////////////////////////////////////////////
 * Module: Error.c
 * Author: Ilensys
 *
 * Created on 11 June, 2022, 10:31 AM
 * 
 * Description:
 * This module contains definitions of error monitoring functions.
 *  
 * Note:
 *  MCU supported: STM32L4P5VGT6
 * /////////////////////////////////////////////////////////////////////////////
*/

/* Includes */
#include "MyMain.h"
#include "DisplayTxHandlers.h"
#include "DispUIkeyhandler.h"
#include "GraphData.h"

/* Declaration of external global variables */
extern uint32_t data_flag;
extern uint32_t error_flag[];
extern uint32_t event_flag[];
extern uint32_t warning_flag;

uint8_t Reminder_Id;

uint32_t System_Status[MAX_ERROR_FLAGS] = {0};

ErrLogStruct ErrLogData[MAX_UI_ERROR_LOGS];
uint8_t HeadErrIndex = 0; //Will point to the latest error
uint8_t TotalErrLogs = 0;
uint8_t UpdateErrorScreen = 0;
extern  AlarmSettingsStruct UIAlarmSettingsData;

void InitializeErrLogData(void);
void AddErrLogData(ErrFlagEnum ErrFlagId, uint8_t ErrIndex);
void RemoveErrLogData(ErrFlagEnum ErrFlagId, uint8_t ErrIndex);

extern void error_set_clear_fun();
extern void SendN16DataToDisplay(uint32_t VPAddr, uint16_t Data);
extern uint8_t mute_seq_start_flg;
/* Declaration of global variables */
// Group1 error info structure
const ERR_INFO err_info1[ERR_BITS_GROUP1] = {
  {MSG_ADC_EOC_TIMEOUT,          sizeof(MSG_ADC_EOC_TIMEOUT)},
  {MSG_I2C_TIMEOUT,              sizeof(MSG_I2C_TIMEOUT)},
  {MSG_SPI_TIMEOUT,              sizeof(MSG_SPI_TIMEOUT)},
  {MSG_UART_TIMEOUT,             sizeof(MSG_UART_TIMEOUT)},
  {MSG_MSG_TX_FAIL,              sizeof(MSG_MSG_TX_FAIL)},
  {MSG_MSG_RX_FAIL,              sizeof(MSG_MSG_RX_FAIL)},
  {MSG_ETH_TX_FAIL,              sizeof(MSG_ETH_TX_FAIL)},
  {MSG_ETH_RX_FAIL,              sizeof(MSG_ETH_RX_FAIL)},
  {MSG_WIFI_TX_FAIL,             sizeof(MSG_WIFI_TX_FAIL)},
  {MSG_WIFI_RX_FAIL,             sizeof(MSG_WIFI_RX_FAIL)},
  {MSG_UI_TX_FAIL,               sizeof(MSG_UI_TX_FAIL)},
  {MSG_UI_RX_FAIL,               sizeof(MSG_UI_RX_FAIL)},
  {MSG_UI_INIT_FAIL,             sizeof(MSG_UI_INIT_FAIL)},
  {MSG_RTC_FAIL,                 sizeof(MSG_RTC_FAIL)},
  {MSG_RTD1_INIT,                sizeof(MSG_RTD1_INIT)},
  {MSG_RTD1_SOC,                 sizeof(MSG_RTD1_SOC)},
  {MSG_RTD1_EOC,                 sizeof(MSG_RTD1_EOC)},
  {MSG_LEVEL_DETECTOR,           sizeof(MSG_LEVEL_DETECTOR)},
  {MSG_EEPROM_TXN,               sizeof(MSG_EEPROM_TXN)},
  {MSG_SD_CARD,                  sizeof(MSG_SD_CARD)},
  {MSG_USB_INIT,                 sizeof(MSG_USB_INIT)},
  {MSG_USB_TXN,                  sizeof(MSG_USB_TXN)},
  {MSG_TLS_CONN,                 sizeof(MSG_TLS_CONN)},
  {MSG_MQTT_CONN,                sizeof(MSG_MQTT_CONN)},
  {MSG_MQTT_PUB,                 sizeof(MSG_MQTT_PUB)},
  {MSG_MQTT_SUB,                 sizeof(MSG_MQTT_SUB)},
  {MSG_DM_TXN,                   sizeof(MSG_DM_TXN)},
  {MSG_CM_TXN,                   sizeof(MSG_CM_TXN)},
  {MSG_RTD1_BAD,                 sizeof(MSG_RTD1_BAD)},
  {MSG_RTD2_BAD,                 sizeof(MSG_RTD2_BAD)},
  {MSG_THERM_BAD,                sizeof(MSG_THERM_BAD)},
  {MSG_DPT_BAD,                  sizeof(MSG_DPT_BAD)},
  // Add 4 more entries
  // TBD

};

// Group2 error info structure
const ERR_INFO err_info2[ERR_BITS_GROUP2] = {
  {MSG_BATT_HIGH,                sizeof(MSG_BATT_HIGH)},
  {MSG_BATT_LOW,                 sizeof(MSG_BATT_LOW)},
  {MSG_MAINS_HIGH,               sizeof(MSG_MAINS_HIGH)},       // Not used
  {MSG_MAINS_LOW,                sizeof(MSG_MAINS_LOW)},        // Not used
  {MSG_TEMP1_HIGH,               sizeof(MSG_TEMP1_HIGH)},
  {MSG_TEMP1_LOW,                sizeof(MSG_TEMP1_LOW)},
  {MSG_LEVEL_HIGH,               sizeof(MSG_LEVEL_HIGH)},
  {MSG_LEVEL_LOW,                sizeof(MSG_LEVEL_LOW)},
  {MSG_GBP_VALVE_STUCK,          sizeof(MSG_GBP_VALVE_STUCK)},
  {MSG_FILL_VALVE_STUCK,         sizeof(MSG_FILL_VALVE_STUCK)},
  {MSG_IMPROPER_FILL,            sizeof(MSG_IMPROPER_FILL)},    // To be implemented
  {MSG_LN2_SHORT_FILL,           sizeof(MSG_LN2_SHORT_FILL)},   // To be implemented
  {MSG_LID_STUCK,                sizeof(MSG_LID_STUCK)},        // To be implemented
  {MSG_UI_USR_CRED_CRC,          sizeof(MSG_UI_USR_CRED_CRC)},
  {MSG_UI_USR_PARAM_CRC,         sizeof(MSG_UI_USR_PARAM_CRC)},
  {MSG_UI_USR_CAL_CRC,           sizeof(MSG_UI_USR_CAL_CRC)},
  {MSG_DP_SENSOR,                sizeof(MSG_DP_SENSOR)},        // To be implemented
  {MSG_WIFI_MOD_FAILED,          sizeof(MSG_WIFI_MOD_FAILED)},
  {MSG_RTD2_INIT,                sizeof(MSG_RTD2_INIT)},
  {MSG_RTD2_SOC,                 sizeof(MSG_RTD2_SOC)},
  {MSG_RTD2_EOC,                 sizeof(MSG_RTD2_EOC)},
  {MSG_TEMP2_HIGH,               sizeof(MSG_TEMP2_HIGH)},
  {MSG_TEMP2_LOW,                sizeof(MSG_TEMP2_LOW)},
  {MSG_BIST_SRAM_MEM,            sizeof(MSG_BIST_SRAM_MEM)},
  {MSG_BIST_FLASH_MEM,           sizeof(MSG_BIST_FLASH_MEM)},
  {MSG_BIST_RTD1_FDC,            sizeof(MSG_BIST_RTD1_FDC)},    // RTD1 fault detection cycle test failed
  {MSG_BIST_RTD2_FDC,            sizeof(MSG_BIST_RTD2_FDC)},    // RTD2 fault detection cycle test failed
  {MSG_GPB_SENS_THR_FAIL,        sizeof(MSG_GPB_SENS_THR_FAIL)},
  {MSG_MFV_SENS_THR_FAIL,        sizeof(MSG_MFV_SENS_THR_FAIL)},
  // Add 2 more entries
  // TBD

};

// Group3 error info structure
const ERR_INFO err_info3[ERR_BITS_GROUP3] = {
  {MSG_BIST_RTD3_FDC,            sizeof(MSG_BIST_RTD3_FDC)},
  {MSG_RTD3_INIT,                sizeof(MSG_RTD3_INIT)},
  {MSG_RTD3_SOC,                 sizeof(MSG_RTD3_SOC)},
  {MSG_RTD3_EOC,                 sizeof(MSG_RTD3_EOC)},
  {MSG_BIST_RTD4_FDC,            sizeof(MSG_BIST_RTD4_FDC)},
  {MSG_RTD4_INIT,                sizeof(MSG_RTD4_INIT)},
  {MSG_RTD4_SOC,                 sizeof(MSG_RTD4_SOC)},
  {MSG_RTD4_EOC,                 sizeof(MSG_RTD4_EOC)},
  {MSG_WIZNET_SOCKET_FLT,        sizeof(MSG_WIZNET_SOCKET_FLT)},
  {MSG_WIZNET_TCP_TX_FLT,        sizeof(MSG_WIZNET_TCP_TX_FLT)},
  {MSG_WIZNET_TCP_RX_FLT,        sizeof(MSG_WIZNET_TCP_RX_FLT)},
  {MSG_DHCP_RESP_TIMEOUT,        sizeof(MSG_DHCP_RESP_TIMEOUT)},
  {MSG_DNS_RESP_TIMEOUT,         sizeof(MSG_DNS_RESP_TIMEOUT)},
};

// Warning info structure
const WRN_INFO wrn_info[WRN_BITS] = {
  {MSG_BATTERY_LT20P,            sizeof(MSG_BATTERY_LT20P)},
  {MSG_MAINS_LOSS,               sizeof(MSG_MAINS_LOSS)},
  {MSG_NO_SD_CARD,               sizeof(MSG_NO_SD_CARD)},
  {MSG_SD_CARD_ACCESS_ERROR,     sizeof(MSG_SD_CARD_ACCESS_ERROR)},
  {MSG_USB_DEV_UNKNOWN,          sizeof(MSG_USB_DEV_UNKNOWN)},
  {MSG_NO_WIFI_CONN,             sizeof(MSG_NO_WIFI_CONN)},
  {MSG_NO_IOT_CONN,              sizeof(MSG_NO_IOT_CONN)},
  {MSG_USER_LOGIN_FAILED,        sizeof(MSG_USER_LOGIN_FAILED)},
  {MSG_USER_LOGIN_LOCKED,        sizeof(MSG_USER_LOGIN_LOCKED)},
  {MSG_HIGH_LN2_CONSUME,         sizeof(MSG_HIGH_LN2_CONSUME)},
  {MSG_THR_CALIB_FAILED,         sizeof(MSG_THR_CALIB_FAILED)},
  {MSG_RTD1_CALIB_FAILED,        sizeof(MSG_RTD1_CALIB_FAILED)},
  {MSG_RTD2_CALIB_FAILED,        sizeof(MSG_RTD2_CALIB_FAILED)},
  {MSG_RTD3_CALIB_FAILED,        sizeof(MSG_RTD3_CALIB_FAILED)},
  {MSG_RTD4_CALIB_FAILED,        sizeof(MSG_RTD4_CALIB_FAILED)},
  {MSG_DPT_CALIB_FAILED,         sizeof(MSG_DPT_CALIB_FAILED)},
  {MSG_LN2_SUPPLY_REMIND,        sizeof(MSG_LN2_SUPPLY_REMIND)},
  {MSG_MAINTENANCE_REMIND,       sizeof(MSG_MAINTENANCE_REMIND)},
  {MSG_LN2_LVL_CHK_REMIND,       sizeof(MSG_LN2_LVL_CHK_REMIND)},
  {MSG_LN2_FILL_REMIND,          sizeof(MSG_LN2_FILL_REMIND)},
  // Add more entries
  // TBD

};

// Warning clear info structure
const WRN_INFO wrn_clr_info[WRN_BITS] = {
  {MSG_CLR_BATTERY_LT20P,        sizeof(MSG_CLR_BATTERY_LT20P)},
  {MSG_CLR_MAINS_LOSS,           sizeof(MSG_CLR_MAINS_LOSS)},
  {MSG_CLR_NO_SD_CARD,           sizeof(MSG_CLR_NO_SD_CARD)},
  {MSG_CLR_SD_CARD_ACCESS_ERROR, sizeof(MSG_CLR_SD_CARD_ACCESS_ERROR)},
  {MSG_CLR_USB_DEV_UNKNOWN,      sizeof(MSG_CLR_USB_DEV_UNKNOWN)},
  {MSG_CLR_NO_WIFI_CONN,         sizeof(MSG_CLR_NO_WIFI_CONN)},
  {MSG_CLR_NO_IOT_CONN,          sizeof(MSG_CLR_NO_IOT_CONN)},
  {MSG_CLR_USER_LOGIN_FAILED,    sizeof(MSG_CLR_USER_LOGIN_FAILED)},
  {MSG_CLR_USER_LOGIN_LOCKED,    sizeof(MSG_CLR_USER_LOGIN_LOCKED)},
  {MSG_CLR_HIGH_LN2_CONSUME,     sizeof(MSG_CLR_HIGH_LN2_CONSUME)},
  {MSG_CLR_THR_CALIB_FAILED,     sizeof(MSG_CLR_THR_CALIB_FAILED)},
  {MSG_CLR_RTD1_CALIB_FAILED,    sizeof(MSG_CLR_RTD1_CALIB_FAILED)},
  {MSG_CLR_RTD2_CALIB_FAILED,    sizeof(MSG_CLR_RTD2_CALIB_FAILED)},
  {MSG_CLR_RTD3_CALIB_FAILED,    sizeof(MSG_CLR_RTD3_CALIB_FAILED)},
  {MSG_CLR_RTD4_CALIB_FAILED,    sizeof(MSG_CLR_RTD4_CALIB_FAILED)},
  {MSG_CLR_DPT_CALIB_FAILED,     sizeof(MSG_CLR_DPT_CALIB_FAILED)},
  {MSG_CLR_LN2_SUPPLY_REMIND,    sizeof(MSG_CLR_LN2_SUPPLY_REMIND)},
  {MSG_CLR_MAINTENANCE_REMIND,   sizeof(MSG_CLR_MAINTENANCE_REMIND)},
  {MSG_CLR_LN2_LVL_CHK_REMIND,   sizeof(MSG_CLR_LN2_LVL_CHK_REMIND)},
  {MSG_CLR_LN2_FILL_REMIND,      sizeof(MSG_CLR_LN2_FILL_REMIND)},
  // Add more entries
  // TBD

};

// Group1 error clear info structure
const ERR_INFO err_clr_info1[ERR_BITS_GROUP1] = {
  {MSG_CLR_ADC_EOC_TIMEOUT,      sizeof(MSG_CLR_ADC_EOC_TIMEOUT)},
  {MSG_CLR_I2C_TIMEOUT,          sizeof(MSG_CLR_I2C_TIMEOUT)},
  {MSG_CLR_SPI_TIMEOUT,          sizeof(MSG_CLR_SPI_TIMEOUT)},
  {MSG_CLR_UART_TIMEOUT,         sizeof(MSG_CLR_UART_TIMEOUT)},
  {MSG_CLR_TX_FAIL,              sizeof(MSG_CLR_TX_FAIL)},
  {MSG_CLR_RX_FAIL,              sizeof(MSG_CLR_RX_FAIL)},
  {MSG_CLR_ETH_TX_FAIL,          sizeof(MSG_CLR_ETH_TX_FAIL)},
  {MSG_CLR_ETH_RX_FAIL,          sizeof(MSG_CLR_ETH_RX_FAIL)},
  {MSG_CLR_WIFI_TX_FAIL,         sizeof(MSG_CLR_WIFI_TX_FAIL)},
  {MSG_CLR_WIFI_RX_FAIL,         sizeof(MSG_CLR_WIFI_RX_FAIL)},
  {MSG_CLR_UI_TX_FAIL,           sizeof(MSG_CLR_UI_TX_FAIL)},
  {MSG_CLR_UI_RX_FAIL,           sizeof(MSG_CLR_UI_RX_FAIL)},
  {MSG_CLR_UI_INIT_FAIL,         sizeof(MSG_CLR_UI_INIT_FAIL)},
  {MSG_CLR_RTC_FAIL,             sizeof(MSG_CLR_RTC_FAIL)},
  {MSG_CLR_RTD1_INIT,            sizeof(MSG_CLR_RTD1_INIT)},
  {MSG_CLR_RTD1_SOC,             sizeof(MSG_CLR_RTD1_SOC)},
  {MSG_CLR_RTD1_EOC,             sizeof(MSG_CLR_RTD1_EOC)},
  {MSG_CLR_LEVEL_DETECTOR,       sizeof(MSG_CLR_LEVEL_DETECTOR)},
  {MSG_CLR_EEPROM_TXN,           sizeof(MSG_CLR_EEPROM_TXN)},
  {MSG_CLR_SD_CARD,              sizeof(MSG_CLR_SD_CARD)},
  {MSG_CLR_USB_INIT,             sizeof(MSG_CLR_USB_INIT)},
  {MSG_CLR_USB_TXN,              sizeof(MSG_CLR_USB_TXN)},
  {MSG_CLR_TLS_CONN,             sizeof(MSG_CLR_TLS_CONN)},
  {MSG_CLR_MQTT_CONN,            sizeof(MSG_CLR_MQTT_CONN)},
  {MSG_CLR_MQTT_PUB,             sizeof(MSG_CLR_MQTT_PUB)},
  {MSG_CLR_MQTT_SUB,             sizeof(MSG_CLR_MQTT_SUB)},
  {MSG_CLR_DM_TXN,               sizeof(MSG_CLR_DM_TXN)},
  {MSG_CLR_CM_TXN,               sizeof(MSG_CLR_CM_TXN)},
  // Add 4 more entries
  // TBD

};

// Group2 error clear info structure
const ERR_INFO err_clr_info2[ERR_BITS_GROUP2] = {
  {MSG_CLR_BATT_HIGH,            sizeof(MSG_CLR_BATT_HIGH)},
  {MSG_CLR_BATT_LOW,             sizeof(MSG_CLR_BATT_LOW)},
  {MSG_CLR_MAINS_HIGH,           sizeof(MSG_CLR_MAINS_HIGH)},       // Not used
  {MSG_CLR_MAINS_LOW,            sizeof(MSG_CLR_MAINS_LOW)},        // Not used
  {MSG_CLR_TEMP1_HIGH,           sizeof(MSG_CLR_TEMP1_HIGH)},
  {MSG_CLR_TEMP1_LOW,            sizeof(MSG_CLR_TEMP1_LOW)},
  {MSG_CLR_LEVEL_HIGH,           sizeof(MSG_CLR_LEVEL_HIGH)},
  {MSG_CLR_LEVEL_LOW,            sizeof(MSG_CLR_LEVEL_LOW)},
  {MSG_CLR_GBP_VALVE_STUCK,      sizeof(MSG_CLR_GBP_VALVE_STUCK)},
  {MSG_CLR_FILL_VALVE_STUCK,     sizeof(MSG_CLR_FILL_VALVE_STUCK)},
  {MSG_CLR_IMPROPER_FILL,        sizeof(MSG_CLR_IMPROPER_FILL)},    // To be implemented
  {MSG_CLR_LN2_SHORT_FILL,       sizeof(MSG_CLR_LN2_SHORT_FILL)},   // To be implemented
  {MSG_CLR_LID_STUCK,            sizeof(MSG_CLR_LID_STUCK)},        // To be implemented
  {MSG_CLR_UI_USR_CRED_CRC,      sizeof(MSG_CLR_UI_USR_CRED_CRC)},
  {MSG_CLR_UI_USR_PARAM_CRC,     sizeof(MSG_CLR_UI_USR_PARAM_CRC)},
  {MSG_CLR_UI_USR_CAL_CRC,       sizeof(MSG_CLR_UI_USR_CAL_CRC)},
  {MSG_CLR_DP_SENSOR,            sizeof(MSG_CLR_DP_SENSOR)},        // To be implemented
  {MSG_CLR_WIFI_MOD_FAILED,      sizeof(MSG_CLR_WIFI_MOD_FAILED)},
  {MSG_CLR_RTD2_INIT,            sizeof(MSG_CLR_RTD2_INIT)},
  {MSG_CLR_RTD2_SOC,             sizeof(MSG_CLR_RTD2_SOC)},
  {MSG_CLR_RTD2_EOC,             sizeof(MSG_CLR_RTD2_EOC)},
  {MSG_CLR_TEMP2_HIGH,           sizeof(MSG_CLR_TEMP2_HIGH)},
  {MSG_CLR_TEMP2_LOW,            sizeof(MSG_CLR_TEMP2_LOW)},
  {MSG_CLR_BIST_SRAM_MEM,        sizeof(MSG_CLR_BIST_SRAM_MEM)},
  {MSG_CLR_BIST_FLASH_MEM,       sizeof(MSG_CLR_BIST_FLASH_MEM)},
  {MSG_CLR_BIST_RTD1_FDC,        sizeof(MSG_CLR_BIST_RTD1_FDC)},    // RTD1 fault detection cycle test failed
  {MSG_CLR_BIST_RTD2_FDC,        sizeof(MSG_CLR_BIST_RTD2_FDC)},    // RTD2 fault detection cycle test failed
  {MSG_CLR_GPB_SENS_THR_FAIL,    sizeof(MSG_CLR_GPB_SENS_THR_FAIL)},
  {MSG_CLR_MFV_SENS_THR_FAIL,    sizeof(MSG_CLR_MFV_SENS_THR_FAIL)},
  {MSG_CLR_USB_RAM_DISK,         sizeof(MSG_CLR_USB_RAM_DISK)},
  // Add 3 more entries
  // TBD

};

// Group3 error clear info structure
const ERR_INFO err_clr_info3[ERR_BITS_GROUP3] = {
  {MSG_CLR_BIST_RTD3_FDC,         sizeof(MSG_CLR_BIST_RTD3_FDC)},
  {MSG_CLR_BIST_RTD3_FDC,         sizeof(MSG_CLR_BIST_RTD3_FDC)},
  {MSG_CLR_RTD3_INIT,             sizeof(MSG_CLR_RTD3_INIT)},
  {MSG_CLR_RTD3_SOC,              sizeof(MSG_CLR_RTD3_SOC)},
  {MSG_CLR_RTD3_EOC,              sizeof(MSG_CLR_RTD3_EOC)},
  {MSG_CLR_BIST_RTD4_FDC,         sizeof(MSG_CLR_BIST_RTD4_FDC)},
  {MSG_CLR_RTD4_INIT,             sizeof(MSG_CLR_RTD4_INIT)},
  {MSG_CLR_RTD4_SOC,              sizeof(MSG_CLR_RTD4_SOC)},
  {MSG_CLR_RTD4_EOC,              sizeof(MSG_CLR_RTD4_EOC)},
  {MSG_CLR_WIZNET_SOCKET_FLT,     sizeof(MSG_CLR_WIZNET_SOCKET_FLT)},
  {MSG_CLR_WIZNET_TCP_TX_FLT,     sizeof(MSG_CLR_WIZNET_TCP_TX_FLT)},
  {MSG_CLR_WIZNET_TCP_RX_FLT,     sizeof(MSG_CLR_WIZNET_TCP_RX_FLT)},
  {MSG_CLR_DHCP_RESP_TIMEOUT,     sizeof(MSG_CLR_DHCP_RESP_TIMEOUT)},
  {MSG_CLR_DNS_RESP_TIMEOUT,      sizeof(MSG_CLR_DNS_RESP_TIMEOUT)},
};

const EventLogTableStruct EventLogTable[MAX_ERROR_FLAGS][32] = {

{//Error
	{ERR_DISPLAY_INTT,		ALARM_ONCE_SD_NOTIFICATION,	"DI1, Display Init Failed!",		NULL	},
	{ERR_EEPROM_FAILURE,	ALL_ALARM_ONCE_NOTIFICATION,"EE1, EEPROM RW Error!",			NULL	},
	{ERR_DP_SENSOR_FAILURE,	ALL_NOTIFICATION,			"LD1, DP Sensor Faulty!",			NULL	},
	{ERR_THERMISTOR_FAILURE,ALL_NOTIFICATION,			"LT1, Therm Lvl Sens Faulty!",		NULL	},
	{ERR_RTD1_SENSOR_FAILURE,ALL_NOTIFICATION,			"T11, T1 Open!",					NULL	},
	{ERR_RTD2_SENSOR_FAILURE,ALL_NOTIFICATION,			"T21, T2 Open!",					NULL	},
	{ERR_LN2_LEVEL_HIGH,	ALL_NOTIFICATION,			"LV3, High Level!",					"LV5,High Lvl Alarm Cleared!"	},
	{ERR_LN2_LEVEL_LOW,		ALL_NOTIFICATION,			"LV2, Low Level!",					"LV4, Low Lvl Alarm Cleared!"	},
	{ERR_NO_LN2_SUPPLY,		ALL_NOTIFICATION,			"LV6, No LN2 Supply!",				"LS2, No LN2 Supply Alarm Cleared!"	},
	{ERR_LN2_SHORT_FILL,	ALL_NOTIFICATION,			"LF3, LN2 Short Fill!",				NULL	},
	{ERR_LN2_IMPROPER_FILL,	ALL_NOTIFICATION,			"LF4, LN2 Improper Fill!",			NULL	},
	{ERR_T1_HIGH,			ALL_NOTIFICATION,			"T13, T1 High!",					"T15, T1 High Alarm cleared!"	},
	{ERR_T2_HIGH,			ALL_NOTIFICATION,			"T23, T2 High!",					"T25, T2 High Alarm Cleared!"	},
	{ERR_T1_LOW,			ALL_NOTIFICATION,			"T12, T1 Low!",						"T14, T1 Low Alarm Cleared!"	},
	{ERR_T2_LOW,			ALL_NOTIFICATION,			"T22, T2 Low!",						"T24, T2 Low Alarm Cleared!"	},
	{ERR_LID_OPEN_TOO_LONG,	ALL_NOTIFICATION,			"LI2, LID Open Too Long!",			NULL },
	{ERR_GBP_STUCK_OPEN,	ALL_NOTIFICATION,			"LG8, GBP Stuck Open!",				NULL	},
	{ERR_MFV_STUCK_OPEN,	ALL_NOTIFICATION,			"LM8, MFV Stuck Open!",				NULL	},
	{ERR_RFV_STUCK_OPEN,	ALL_NOTIFICATION,			"RF3, RFV Stuck Open!",				NULL	},
	{ERR_3WAY_STUCK_OPEN,	ALL_NOTIFICATION,			"F3WV, 3 Way Stuck Open!",			NULL	},
	{ERR_GBP_THERMISTOR_OPEN,ALL_NOTIFICATION,			"GB4, GBP Sensor Open!",			NULL	},
	{ERR_MFV_THERMISTOR_OPEN,ALL_NOTIFICATION,			"MF4, MFV Sensor Open!",			NULL	},
	{ERR_SD_CARD_NOT_PRESENT,UI_ALARM_ONCE_NOTIFICATION,"FSDN, SD Card Not Present!",		NULL	},
	{ERR_SD_CARD_FAILURE,	UI_ALARM_ONCE_NOTIFICATION,	"FSDF, SD Card Failure!",			NULL	},
	{ERR_WIFI_MODULE_FAILURE,ALL_ALARM_ONCE_NOTIFICATION,"WF1, Wi-Fi Module Failure!",		NULL	},
	{ERR_UI_COM_FAILURE,    SD_NOTIFICATION,             "UI, Ui communication failure",    NULL    },
	{ERR_INSERT_SD_FOR_CERT_UPLOAD,UI_ALARM_ONCE_NOTIFICATION,"WSDR, Insert SD to upload cert!",  NULL  },
	{ERR_DISP_TX_OVERFLOW,  SD_NOTIFICATION,            "DI2, Buffer Over Flow",          NULL    }
},
{//Error 2 flag
	{ },
},
{//Wrning flag
	{WRN_LN2_USAGE_HIGH,	ALL_ALARM_ONCE_NOTIFICATION,"LV7, High LN2 Consumption!",		NULL	},
	{WRN_BATT_NOT_CONNECTED,ALL_ALARM_ONCE_NOTIFICATION,"MP4, Battery Not Connected!",		NULL	},
	{WRN_BATT_VOLTAGE_LOW,	ALL_ALARM_ONCE_NOTIFICATION,"MP3, Battery Voltage Low!",		NULL	},
	{WRN_DP_CALIB_FAILURE,	NO_NOTIFICATION,			"WDCF, DP Cal Failed!",				NULL	},
	{WRN_RTD1_CALIB_FAILURE,NO_NOTIFICATION,			"WRCF, RTD1 Cal Failed!",			NULL	},
	{WRN_RTD2_CALIB_FAILURE,NO_NOTIFICATION,			"WR2F, RTD2 Cal Failed!",			NULL	},
	{WRN_LN2_SUPPLY_REMINDER,ALL_ALARM_ONCE_NOTIFICATION,"WLSR, Supply Reminder!",		"ELSR, Supply Reminder Cleared!"	},
	{WRN_LN2_LEVELCHECK_REMINDER,ALL_ALARM_ONCE_NOTIFICATION,"WLLC, Level Check Reminder!","ELCR, Level Check Reminder Cleared!"	},
	{WRN_LN2_FILL_REMINDER,ALL_ALARM_ONCE_NOTIFICATION,"WLFR, Schedule Fill!",				"ELFR, Schedule Fill Cleared!"	},
	{WRN_MAINTENANCE_REMINDER,ALL_ALARM_ONCE_NOTIFICATION,"WMTR, Maintenance Reminder!",	"EMRC, Maintenance Reminder Cleared!"	},
},
{//Event 0
	{EVT_LN2_FILL_STARTED,	SD_NOTIFICATION,			"LF9, Start Fill!",					"LFS, Stop Fill!"	},
	{EVT_LID_OPENED,		SD_NOTIFICATION,			"LI1, Lid Open!",					"LI3, Lid Close!"	},
	{EVT_GBP_OPENED,		SD_NOTIFICATION,			"GB1, GBP Opened!",					"GB2, GBP Closed!"	},
	{EVT_MFV_OPENED,		SD_NOTIFICATION,			"MF1, MFV Opened!",					"MF2, MFV Closed!"	},
	{EVT_RFV_OPENED,		SD_NOTIFICATION,			"RF1, RFV Opened!",					"RF2, RFV Closed!"	},
	{EVT_3WAY_OPENED,		SD_NOTIFICATION,			NULL,								NULL	},
	{EVT_MAIN_PWR_FAILED,	SD_NOTIFICATION,			"MP1, Mains Failed!",				"MP2, Mains Restored!"	},
	{EVT_USB_CONNECTED,		SD_NOTIFICATION,			"EUSC, USB Connected!",				"EUSD, USB Disconnected!"	},
	{EVT_USER_LOGGED_IN,	SD_NOTIFICATION,			"US1, User Logged In!",				"US2, User Logged Off!"	},
	{EVT_USER_LOCKED_OUT,	UI_SD_NOTIFICATION,			"EULK, User ID Locked!",			NULL	},
	{EVT_EMERGENCY_SW_PRESSED,SD_NOTIFICATION,			"ES1, Emergency Switch Pressed!",	"ES2, Emergency Switch Released!"	},
	{EVT_CALIB_PROCESS_STARTED,SD_NOTIFICATION,			"ECPS, Cal Process Started!",		"ECPC, Cal Process Completed!"	},
	{EVT_DP_CALIB_SUCCESS,	SD_NOTIFICATION,			"DP2, DP Cal Success!",				NULL	},
	{EVT_RTD1_CALIB_SUCCESS,SD_NOTIFICATION,			"T16, T1 Cal Success!",				NULL	},
	{EVT_RTD2_CALIB_SUCCESS,SD_NOTIFICATION,			"T26, T2 Cal Success!",				NULL	},
	{EVT_GBP_PULSE_DRAIN_STARTED,SD_NOTIFICATION,		"GB5, GBP Declogging Started!",		"GB6, GBP Declogging end!"	},
	{EVT_MFV_PULSE_DRAIN_STARTED,SD_NOTIFICATION,		"MF5, MFV Declogging Started!",		"MF6, MFV Declogging end!"	},
	{EVT_DISPLAY_CLOSE,     SD_NOTIFICATION,            "display closing!",                 NULL                    },
	{EVT_WIFI_CONNECTED,    SD_NOTIFICATION,            "WI-FI connected to Access point",    NULL},

}
};

const uint32_t *ErrorFlags[MAX_ERROR_FLAGS] = {
		&System_Status[0],
		&System_Status[1],
		&System_Status[2],
		&System_Status[3]
};

void UpdateUIErrorLog(void);


/* Declaration of local functions */

/* 
 * **************************************
 * **************************************
 * Function Declarations start here
 * **************************************
 * **************************************
 */

/* 
 * *****************************************************************************
 * Function name:   Err_msg_init()
 * Created by: Natarajan Kanniappan
 * Date:       01-Jul-2022
 * Description:
 *  This is the routine that initializes error logging info at "error_flag"
 * Parameters:
 *  Input  : None
 *  Return : None
 * Note:
 * 
 * *****************************************************************************
 */
void Err_msg_init(void)
{
  memset((uint8_t*)&error_flag[0], 0x00, sizeof(uint32_t)*3);
  memset((uint8_t*)&error_flag[1], 0x00, sizeof(uint32_t)*3);
  memset((uint8_t*)&error_flag[2], 0x00, sizeof(uint32_t)*3);
  memset((uint8_t*)&warning_flag, 0x00, sizeof(uint32_t));
  // TBD
  InitializeErrLogData();
}

/* 
 * *****************************************************************************
 * Function name:   Wrn_msg_init()
 * Created by: Natarajan Kanniappan
 * Date:       01-Jul-2022
 * Description:
 *  This is the routine that initializes warning logging info at "warning_flag"
 * Parameters:
 *  Input  : None
 *  Return : None
 * Note:
 *
 * *****************************************************************************
 */
void Wrn_msg_init(void)
{
  memset((uint8_t*)&warning_flag, 0x00, sizeof(uint32_t));
  // TBD

}

void LogMsgToSDCard(ErrFlagEnum ErrFlagId, uint8_t ErrIndex, uint8_t ErrState)
{
	if((System_Status[0] & ERR_SD_CARD_NOT_PRESENT) || (System_Status[0] & ERR_SD_CARD_FAILURE))
	{
		return;
	}
	//ToDo : USB connected log should be logged from USB interface

	if(ErrState == ERROR_RESET)
	{
		if(EventLogTable[ErrFlagId][ErrIndex].EvClearDescp)
		{
			ULOG_INFO(EventLogTable[ErrFlagId][ErrIndex].EvClearDescp);
			AddRealTimeEvent(EventLogTable[ErrFlagId][ErrIndex].EvClearDescp);
		}
	}
	else if(EventLogTable[ErrFlagId][ErrIndex].EvSetDescp)
	{
		if(ErrFlagId == EVENT_FLAG)
		{
			ULOG_INFO(EventLogTable[ErrFlagId][ErrIndex].EvSetDescp);
		}
		else if(ErrFlagId == WARNING_FLAG)
		{
			ULOG_WARNING(EventLogTable[ErrFlagId][ErrIndex].EvSetDescp);
		}
		else
		{
			ULOG_ERROR(EventLogTable[ErrFlagId][ErrIndex].EvSetDescp);
		}
		AddRealTimeEvent(EventLogTable[ErrFlagId][ErrIndex].EvSetDescp);
	}
}

void UpdateUIErrorLog(void)
{
	static uint32_t ErrorFlagStates[MAX_ERROR_FLAGS] = {0x00, 0x00, 0x00, 0x00};// = {error_flag[0],error_flag[1],error_flag[2]};

	error_set_clear_fun();
	for(uint8_t Ctr = 0; Ctr<MAX_ERROR_FLAGS; Ctr++)
	{
		uint32_t ErrorStatus = (ErrorFlagStates[Ctr]^ *ErrorFlags[Ctr]);
		if(ErrorStatus)
		{
			uint32_t BitPos = 0x01;
			for(uint8_t Pos = 0; Pos < 32; Pos++)
			{
				if(ErrorStatus & BitPos)
				{
					if(*ErrorFlags[Ctr] & BitPos)
					{
						//Error Set
						if(EventLogTable[Ctr][Pos].EventNotifyFlag & UI_NOTIFICATION)
						{
							//Notify in UI
							AddErrLogData(Ctr, Pos);
							if((UIAlarmSettingsData.FillValveStuckAlarm)&&(UIAlarmSettingsData.GBPValveStuckAlarm))
							{
								mute_seq_start_flg=0;
							}
							else if((System_Status[ERROR_FLAG_0] & ERR_GBP_STUCK_OPEN)||(System_Status[ERROR_FLAG_0] & ERR_MFV_STUCK_OPEN))
							{
								mute_seq_start_flg=1;
							}
							else
							{
								mute_seq_start_flg=0;
							}
						}
						if(EventLogTable[Ctr][Pos].EventNotifyFlag & ALARM_NOTIFICATION)
						{
							if(EventLogTable[Ctr][Pos].EventNotifyFlag & ALARM_ONCE_NOTIFICATION)
							{
								//Do not repeat alarm for this error/event
							}
							else
							{
								//Repeatable alarm
							}

						}
						if(EventLogTable[Ctr][Pos].EventNotifyFlag & SD_NOTIFICATION)
						{
							//Log message to SD card
							LogMsgToSDCard(Ctr, Pos, ERROR_SET);
							if((System_Status[EVENT_FLAG] & EVT_MAIN_PWR_FAILED)==0)
							{
								SendN16DataToDisplay(0x0809A4, 0);
							    SendN16DataToDisplay(0x0809A2, 1);
							}
							else if((System_Status[EVENT_FLAG] & EVT_MAIN_PWR_FAILED) !=0)
							{
								 SendN16DataToDisplay(0x0809A4, 1);
								 SendN16DataToDisplay(0x0809A2, 0);
							}
						}
					}
					else
					{
						//Error Cleared
						if(EventLogTable[Ctr][Pos].EventNotifyFlag & UI_NOTIFICATION)
						{
							//Notify in UI
							RemoveErrLogData(Ctr, Pos);
						}
						if(EventLogTable[Ctr][Pos].EventNotifyFlag & ALARM_NOTIFICATION)
						{
							//Clear Alarm Notification
						}
						if(EventLogTable[Ctr][Pos].EventNotifyFlag & SD_NOTIFICATION)
						{
							//Log message to SD card
							LogMsgToSDCard(Ctr, Pos, ERROR_RESET);
						}
					}
				}
				BitPos <<= 1;
			}
		}
		ErrorFlagStates[Ctr] = *ErrorFlags[Ctr];
	}
}

#if 0
void UpdateUIErrorLog(void)
{
	static uint32_t ErrorFlagStates[MAX_ERROR_FLAGS] = {0x00, 0x00, 0x00, 0x00};// = {error_flag[0],error_flag[1],error_flag[2]};
	static uint32_t UIErrorMask[MAX_ERROR_FLAGS] = {(ERR_DPT_BAD),
			(ERR_LEVEL_LOW|ERR_TEMP1_LOW|ERR_TEMP2_LOW|ERR_LID_STUCK_OPEN|ERR_FILL_VALVE_STUCK|ERR_GBP_VALVE_STUCK|ERR_LN2_SHORT_FILL|ERR_LOW_BATT_VOLT|ERR_LEVEL_HIGH|ERR_TEMP1_HIGH|ERR_TEMP2_HIGH|ERR_BIST_RTD1_FDC|ERR_BIST_RTD2_FDC),
			0x0,(WRN_NO_SD_CARD|WRN_MAINTENANCE_REMIND|WRN_LN2_SUPPLY_REMIND|WRN_LN2_LVL_CHK_REMIND|WRN_LN2_FILL_REMIND )};//(WRN_HIGH_LN2_CONSUME|WRN_LOST_MAINS_VOLT|WRN_MAINTENANCE_REMIND|WRN_THR_CALIB_FAILED|WRN_DPT_CALIB_FAILED|WRN_RTD1_CALIB_FAILED|WRN_RTD2_CALIB_FAILED|WRN_LN2_SUPPLY_REMIND|WRN_LN2_LVL_CHK_REMIND)
	error_set_clear_fun();
	for(uint8_t Ctr = 0; Ctr<MAX_ERROR_FLAGS; Ctr++)
	{
		uint32_t ErrorStatus = (ErrorFlagStates[Ctr]^ *ErrorFlags[Ctr]) & UIErrorMask[Ctr];
		if(ErrorStatus)
		{
			uint32_t BitPos = 0x01;
			for(uint8_t Pos = 0; Pos < 32; Pos++)
			{
				if(ErrorStatus & BitPos)
				{
					if(*ErrorFlags[Ctr] & BitPos)
					{
						//Error Set
						AddErrLogData(Ctr, Pos);
						mute_seq_start_flg=0;
					}
					else
					{
						//Error Cleared
						RemoveErrLogData(Ctr, Pos);
					}
				}
				BitPos <<= 1;
			}
		}
		ErrorFlagStates[Ctr] = *ErrorFlags[Ctr];
	}
}
#endif

void InitializeErrLogData(void)
{
	memset(ErrLogData, 0xFF, sizeof(ErrLogData));
}

void AddErrLogData(ErrFlagEnum ErrFlagId, uint8_t ErrIndex)
{
	uint8_t Ctr = 0;
	for(Ctr = 0; Ctr<MAX_UI_ERROR_LOGS; Ctr++)
	{
		if((ErrLogData[Ctr].PrevIndex == 0xFF) && (ErrLogData[Ctr].NextIndex == 0xFF) && \
		   (ErrLogData[Ctr].ErrFlag == 0xFF) && (ErrLogData[Ctr].ErrIndex == 0xFF))
			break;
	}
	if(Ctr == MAX_UI_ERROR_LOGS)//No Space found
		return;
	//Add the log index
	ErrLogData[Ctr].ErrFlag = ErrFlagId;
	ErrLogData[Ctr].ErrIndex = ErrIndex;
	if(TotalErrLogs == 0)
	{
		ErrLogData[Ctr].PrevIndex = 0xFF;
		ErrLogData[Ctr].NextIndex = 0xFF;
	}
	else
	{
		ErrLogData[Ctr].PrevIndex = HeadErrIndex;
		ErrLogData[HeadErrIndex].NextIndex = Ctr;
	}
	HeadErrIndex = Ctr;
	TotalErrLogs++;
	UpdateErrorScreen = 1;
	LoadErrorScreen();
}

void RemoveErrLogData(ErrFlagEnum ErrFlagId, uint8_t ErrIndex)
{
	uint8_t Ctr = 0;
	for(Ctr = 0; Ctr<MAX_UI_ERROR_LOGS; Ctr++)
	{
		if((ErrLogData[Ctr].ErrFlag == ErrFlagId) && (ErrLogData[Ctr].ErrIndex == ErrIndex))
			break;
	}
	if(Ctr == MAX_UI_ERROR_LOGS)//No Space found
		return;

	//Remove the log index
	if((ErrLogData[Ctr].PrevIndex == 0xFF) && (ErrLogData[Ctr].NextIndex == 0xFF)) // First & last entry
	{
		HeadErrIndex = 0;
	}
	else if(ErrLogData[Ctr].PrevIndex == 0xFF) // oldest entry
	{
		ErrLogData[ErrLogData[Ctr].NextIndex].PrevIndex = 0xFF;
	}
	else if(ErrLogData[Ctr].NextIndex == 0xFF) // latest entry
	{
		ErrLogData[ErrLogData[Ctr].PrevIndex].NextIndex = 0xFF;
		HeadErrIndex = ErrLogData[Ctr].PrevIndex;
	}
	else
	{
		ErrLogData[ErrLogData[Ctr].PrevIndex].NextIndex = ErrLogData[Ctr].NextIndex;
		ErrLogData[ErrLogData[Ctr].NextIndex].PrevIndex = ErrLogData[Ctr].PrevIndex;
	}

//	if(HeadErrIndex == Ctr)
//	{
//		HeadErrIndex = ErrLogData[Ctr].PrevIndex;
//		ErrLogData[ErrLogData[Ctr].PrevIndex].PrevIndex = 0xFF;
//	}

	ErrLogData[Ctr].ErrFlag = 0xFF;
	ErrLogData[Ctr].ErrIndex = 0xFF;
	ErrLogData[Ctr].PrevIndex = 0xFF;
	ErrLogData[Ctr].NextIndex = 0xFF;
	if(TotalErrLogs)
		TotalErrLogs--;

	UpdateErrorScreen = 1;
	LoadErrorScreen();
}

uint8_t GetTotalItemIndex()
{
	return TotalErrLogs;
}

uint8_t GetNextItemIndex(uint8_t CurrentIndex)
{
	if(CurrentIndex >= MAX_UI_ERROR_LOGS)
		return 0xFF;
	return ErrLogData[CurrentIndex].NextIndex;
}

uint8_t GetPrevItemIndex(uint8_t CurrentIndex)
{
	if(CurrentIndex >= MAX_UI_ERROR_LOGS)
		return 0xFF;
	return ErrLogData[CurrentIndex].PrevIndex;
}

uint8_t GetNthItemIndex(uint8_t SeqNo)
{
	uint8_t HeadIndex = HeadErrIndex;
	if(SeqNo >= MAX_UI_ERROR_LOGS)
		return 0xFF;

	for(uint8_t Ctr = 0; (Ctr < MAX_UI_ERROR_LOGS); Ctr++)
	{
		SeqNo--;
		if(!SeqNo)
		{
			return HeadIndex;
		}

		if(HeadIndex < MAX_UI_ERROR_LOGS)
		{
			HeadIndex = ErrLogData[HeadIndex].PrevIndex;
		}
		else  //end of list
		{
			return 0xFF;
		}

	}
	return 0xFF;
}

uint8_t GetListItemsInOrder(uint8_t IndexReset)
{
	static uint8_t HeadIndex = 0;

	if(IndexReset)
	{
		HeadIndex = HeadErrIndex;
		return HeadErrIndex;
	}

	if(HeadIndex < MAX_UI_ERROR_LOGS)
	{
		HeadIndex = ErrLogData[HeadIndex].PrevIndex;
	}
	else  //end of list
	{
		return 0xFF;
	}

	return HeadIndex;
}

uint8_t GetErrorMessage(uint8_t ErrorLogIndex, uint8_t *Msgptr)
{
	if(ErrorLogIndex >= MAX_UI_ERROR_LOGS)
		return 0; //Don't copy and return 0 length

	if((Msgptr == NULL) || (ErrLogData[ErrorLogIndex].ErrFlag >= MAX_ERROR_FLAGS) || (ErrLogData[ErrorLogIndex].ErrIndex >= ERR_BITS_GROUP1))
		return 0; //Don't copy and return 0 length

	uint8_t FlagId = ErrLogData[ErrorLogIndex].ErrFlag;
	uint8_t Index = ErrLogData[ErrorLogIndex].ErrIndex;

	if(((FlagId==2)&&(Index==6))||((FlagId==2)&&(Index==7))||((FlagId==2)&&(Index==8)))
	{
		Reminder_Id=Index;
		SendN16DataToDisplay(0x080976, 1);
	}
	else
	SendN16DataToDisplay(0x080976, 0);


	if(EventLogTable[FlagId][Index].EvSetDescp)
	{
		char *StrPtr = strchr(EventLogTable[FlagId][Index].EvSetDescp, ',');
		StrPtr++; //Skip ',' char
		StrPtr++; //Skip ' ' char
		uint8_t MsgLen = strlen(StrPtr);
		memcpy(Msgptr, StrPtr, MsgLen+1); // Adding NULL char
		return MsgLen+1;
	}
	return 0;
}

/*
 * *********************************
 * *********************************
 * End of the module: ErrorMon.c
 * *********************************
 * *********************************
 */

