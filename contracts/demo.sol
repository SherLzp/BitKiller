pragma solidity ^0.4.24;
// 0x09a55b101711815600c26d7f1c31178b964bcb4e
contract DateTime {
        function getTime(uint timestamp) public constant returns (uint16);
        function getMonth(uint timestamp) public constant returns (uint8);
        function getDay(uint timestamp) public constant returns (uint8);
        function getNow() public constant returns (uint timestamp); 
        function toTimestamp(uint16 year, uint8 month, uint8 day, uint8 hour, uint8 minute, uint8 second) public constant returns (uint);
}

contract Deposit {
    
    address owner = 0x0; //
    
    uint256 ticket = 0.02 ether;    // 0.02 ether deposit
    
    uint256 balance;
    
    
    uint256 public deposit_ddl;       // send your ether into this contract before "8.31 00:00:00" time in Beijing
    uint256 public setViolation_ddl;  // commitee sets players' 'violation' label before "9.1 21:00:00" time in Beijing
    uint256 public giveBack_ddl;      // return your deposit if you do not break the rules after "9.2 12:00:00" time in Beijing
    
    address public dateTimeAddr = 0xa4334890070c6b8376b89243d665a8e2464af5ca;
    DateTime dateTime = DateTime(dateTimeAddr);
    
    struct account_info{
        bool is_violation;          // true: confiscate the deposit to the host address (default: host address is the owner address )    
                                    // false: give back the deposit(default is false)
        uint primary_id;            // identity, every player will get a primary_id
        address account_address;    // record the account_address so that we can give back the deposit
    }  
    account_info [] accounts_info;
    
    
    
    // constructor function
    constructor() public {
        // owner is the one who deploy this contract
        owner = msg.sender;
        balance = 0;
        deposit_ddl = dateTime.toTimestamp(2018, 8, 30, 16, 0, 0);//dateTime.toTimestamp(2018, 8, 20, 8, 0, 0);//1535702400;//dateTime.toTimestamp(2018, 8, 16, 3, 0, 0);//19:00////dateTime.toTimestamp(2018, 8, 30, 16, 0, 0); // Beijing is UTC/GMT+08:00. So we need to set the time 8 hours earlier 
        setViolation_ddl = dateTime.toTimestamp(2018, 9, 1, 13, 0, 0);//dateTime.toTimestamp(2018, 8, 20, 8, 30, 0);//1535864400;//dateTime.toTimestamp(2018, 8, 16, 4, 0, 0);//20:00////dateTime.toTimestamp(2018, 9, 1, 13, 0, 0);
        giveBack_ddl = dateTime.toTimestamp(2018, 9, 2, 4, 0, 0);//dateTime.toTimestamp(2018, 8, 20, 9, 0, 0);//1535918400;//dateTime.toTimestamp(2018, 8, 16, 5, 0, 0);//21:00////dateTime.toTimestamp(2018, 9, 2, 4, 0, 0);
        
    }
    
    
    // mortgage function. web3 can call this function
    function mortgage(uint primary_id) public payable returns (uint, bool, address, uint){
        require(now < deposit_ddl);                 // before the deposit deadline, you can send the deposit into this contract
        require(msg.value >= ticket);               // check the value
        
        bool exist = false;
        uint len = accounts_info.length;
        for (uint i = 0; i< len;i++){
            if (accounts_info[i].primary_id == primary_id)
            {
                exist = true;
                break;
            }
        }
        
        require(exist == false);        // check if account exists
        
        
        if (msg.value > ticket) {                   // give back spare money
            var refundFee = msg.value - ticket;
            msg.sender.transfer(refundFee);
            
        }
        balance += ticket;
        account_info memory account = account_info(false, primary_id, msg.sender);  //
        accounts_info.push(account);                                               // record account_info
        
    }
    
    
    // set_violation function. web3 can call this function
    function set_violation(uint primary_id) public returns (bool){
        require(msg.sender == owner);           // commitee can call this function
        require(now < setViolation_ddl);        // before setViolation_ddl
        uint len = accounts_info.length;
        for (uint i = 0; i< len;i++){
            if (accounts_info[i].primary_id == primary_id){
               accounts_info[i].is_violation = true;
               return true;
            }
        }
        return false;                           //no such id
    }
    
    // giveBackDeposit function. web3 can call this function
    function giveBackDeposit() public {
        require(owner == msg.sender);           // commitee can call this function
        require(now > giveBack_ddl);                
        uint len = accounts_info.length;                                    // give back deposit if players obey the rules
        for (uint i = 0; i< len;i++){
            if (accounts_info[i].is_violation == false){                    // if player not break rules
                address receiver = accounts_info[i].account_address;        // transfer ticket back 
                accounts_info[i].is_violation == true;                      // avoid transfering many times
                receiver.send(ticket);                                  // give back money
                balance -= ticket;                                           
            }
        }
        
        owner.transfer(balance);                // commitee get the rest balance
    }
    
    // utils function 
    function get_account_info(uint id) public constant returns (uint, bool, address, uint){    // call back function to see the accounts_info
        uint len = accounts_info.length;
        for (uint i = 0; i< len;i++){
            if (accounts_info[i].primary_id == id)
                return (accounts_info[i].primary_id, accounts_info[i].is_violation,accounts_info[i].account_address,accounts_info.length);
        }
        return (0, false, 0, 0x0);              //no such id
    }
    
    //utils function
    function get_balance() public constant returns (uint256){
        return balance;
    }
    
    function account_exist(uint id) public constant returns(bool){
        uint len = accounts_info.length;
        for (uint i = 0; i< len;i++){
            if (accounts_info[i].primary_id == id)
                return true;
        }
        return false;
    }
}