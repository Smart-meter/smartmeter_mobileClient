enum CallToActions {
  NO_ACTION,
  CAPTURE_IMAGE,
  MANUAL_METER_READING,  //There is an error in detecting the meter reading. Please help the system by manually entering the reading details
  CONFIRM_AUTOMATED_METER_READING, //The meter reading entry is ready. Please confirm
  BILL_AMOUNT_DUE, // Bill payment screen
  LINK_UTILITY_ACCOUNT,
}
