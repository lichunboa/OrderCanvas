// SPDX-License-Identifier: MIT
// Standalone demonstration. No broker requests or trade operations.
#property strict
#property script_show_inputs
#include <TicketSizing.mqh>

input double DemoBudgetMoney=20.0;
input double DemoCostPerLot=100.0;
input double DemoMinLot=0.01;
input double DemoMaxLot=100.0;
input double DemoLotStep=0.01;

void OnStart()
{
   const double lots=TicketBudgetVolume(DemoBudgetMoney,DemoCostPerLot,
                                      DemoMinLot,DemoMaxLot,DemoLotStep);
   PrintFormat("OpenUtilities sizing example: budget=%.2f costPerLot=%.2f lots=%.2f",
               DemoBudgetMoney,DemoCostPerLot,lots);
   Print("This example prints a computed result; it never opens or modifies trades.");
}
