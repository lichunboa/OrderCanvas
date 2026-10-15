// SPDX-License-Identifier: MIT
int TicketSizingDigits(const double value)
{
   int digits=2;
   while(value>0.0 && digits<16 && NormalizeDouble(value,digits)==0.0)
      digits++;
   return digits;
}

// Budget sizing never raises a target to the broker minimum or silently caps it.
double TicketBudgetVolume(const double budget,const double costPerLot,
                          const double minimum,const double maximum,const double step)
{
   if(!MathIsValidNumber(budget) || !MathIsValidNumber(costPerLot) ||
      budget<=0.0 || costPerLot<=0.0 || minimum<=0.0 || maximum<minimum || step<=0.0)
      return 0.0;
   const double raw=budget/costPerLot;
   const double epsilon=step*1e-8;
   if(raw<minimum-epsilon || raw>maximum+epsilon)
      return 0.0;
   const double volume=NormalizeDouble(MathFloor((raw+epsilon)/step)*step,8);
   if(volume<minimum-epsilon || volume>maximum+epsilon ||
      volume*costPerLot>budget+MathMax(1e-10,budget*1e-9))
      return 0.0;
   return volume;
}
