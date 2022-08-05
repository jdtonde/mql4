#include <CustomFunctions01.mqh>

int bbPeriod = 20;
int band1Std = 1;
int band2Std = 4;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//---

    Alert("");

   double bbLower1 = iBands(NULL,0,bbPeriod,band1Std,0,PRICE_CLOSE,MODE_LOWER,0);
   double bbUpper1 = iBands(NULL,0,bbPeriod,band1Std,0,PRICE_CLOSE,MODE_UPPER,0);
   double bbMid = iBands(NULL,0,bbPeriod,band1Std,0,PRICE_CLOSE,0,0);
   
   double bbLower2 = iBands(NULL,0,bbPeriod,band2Std,0,PRICE_CLOSE,MODE_LOWER,0);
   double bbUpper2 = iBands(NULL,0,bbPeriod,band2Std,0,PRICE_CLOSE,MODE_UPPER,0);
   
   if(Ask < bbLower1)//buying
   {
      Alert("Price is bellow bbLower1, Sending buy order");
      double stopLossPrice = NormalizeDouble(bbLower2,Digits);
      double takeProfitPrice = NormalizeDouble(bbMid,Digits);;
      Alert("Entry Price = " + Ask);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice);
      
      int orderID = OrderSend(NULL,OP_BUYLIMIT,0.01,Ask,10,stopLossPrice,takeProfitPrice);
      if(orderID < 0) Alert("order rejected. Order error: " + GetLastError());
   }
   else if(Bid > bbUpper1)//shorting
   {
      Alert("Price is above bbUpper1, Sending short order");
      double stopLossPrice = NormalizeDouble(bbUpper2,Digits);
      double takeProfitPrice = NormalizeDouble(bbMid,Digits);
      Alert("Entry Price = " + Bid);
      Alert("Stop Loss Price = " + stopLossPrice);
      Alert("Take Profit Price = " + takeProfitPrice);
	  
	  int orderID = OrderSend(NULL,OP_SELLLIMIT,0.01,Bid,10,stopLossPrice,takeProfitPrice);
	  if(orderID < 0) Alert("order rejected. Order error: " + GetLastError());
   }
  
  }
//+------------------------------------------------------------------+


