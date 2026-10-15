#ifndef TV_WORKBENCH_DOMAIN_MQH
#define TV_WORKBENCH_DOMAIN_MQH
const int TV_WORKBENCH_READY_EVENT=6761;
const string TV_WORKBENCH_NAME="交易工作台";
enum TVWorkbenchBuffer {WB_EMA20=0,WB_EMA_MTF=1,WB_BAR_COUNT=2,WB_ENTRY_EMA=3,WB_ENTRY_MASK=4,WB_EMA_CALC=5};
int WorkbenchInputOffset(const int module){return module==0?4:(module==1?46:60);}
// MetaTrader 6230 reflects input group headers as TYPE_STRING parameters.
int WorkbenchNativeOffset(const int module){return module==0?6:(module==1?49:64);}
int WorkbenchInputCount(const int module){return module==0?42:(module==1?14:16);}
// IndicatorCreate layout actually used (MT5 limit: 64 parameters including the
// name): name, 4 groups, 3 module switches, the original 25/14/15 module inputs,
// revision = 63. The R3 values (PA 26..42, SE 16) travel in the extension file.
#define TV_WORKBENCH_PARAMS 63
#define TV_WORKBENCH_EXT_VALUES 18
int WorkbenchParamOffset(const int module){return module==0?6:(module==1?32:47);}
int WorkbenchParamCount(const int module){return module==0?25:(module==1?14:15);}
string WorkbenchExtensionFile(const long chart){return "TVStudySuiteExt-"+IntegerToString(chart)+".tsv";}
#endif
