package kabam.rotmg.core.commands
{
   import kabam.rotmg.account.core.Account;
   import kabam.rotmg.account.core.commands.ExternalOpenMoneyWindowCommand;
   import kabam.rotmg.account.core.commands.InternalOpenMoneyWindowCommand;
   import kabam.rotmg.account.core.signals.OpenMoneyWindowSignal;
   import kabam.rotmg.account.kabam.KabamAccount;
   import kabam.rotmg.account.web.WebAccount;
   import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
   
   public class ConfigurePaymentsWindowCommand
   {
       
      
      [Inject]
      public var commandMap:ISignalCommandMap;
      
      [Inject]
      public var account:Account;
      
      [Inject]
      public var data:XML;
      
      public function ConfigurePaymentsWindowCommand()
      {
         super();
      }
      
      public function execute() : void
      {
         var useExternal:Boolean = false;
         if(this.account.gameNetwork() == KabamAccount.NETWORK_NAME || this.account.gameNetwork() == WebAccount.NETWORK_NAME)
         {
            useExternal = Boolean(int(this.data.UseExternalPayments));
            if(useExternal)
            {
               this.commandMap.unmap(OpenMoneyWindowSignal).fromCommand(InternalOpenMoneyWindowCommand);
               this.commandMap.map(OpenMoneyWindowSignal).toCommand(ExternalOpenMoneyWindowCommand);
            }
         }
      }
   }
}